module OpenTTD
    class Client
        @events = {}
        @config = Hashie::Mash.new({ 
            :server => { :host => '127.0.0.1', :port => 3979 },
            :player => { :name => 'ottd-bot' }
        })
        
        attr_accessor :payload
        
        def initialize(config = nil, events = nil, &block)
            @tcp = nil
            @udp = UDPConnection.new
            @events ||= events
            @config ||= config
            
            self.class.instance_eval(&block) if block_given?
        end
        
        class << self
            def inherited(subclass)
            end
            
            def config
                klass = superclass ? superclass : self
                @config ||= klass.instance_eval { @config }
            end
            
            def events
                klass = superclass ? superclass : self
                @events ||= klass.instance_eval { @events }
            end
            
            def configure(&block)
                config.instance_eval(&block)
            end
            
            def on(opcode, criteria = nil, &block)
                (events[opcode] ||= []) << [criteria, block]
            end
        end
        
        #configure do
        #    server.host = 'kyra.lon.lividpenguin.com'
        #    player.name = 'ottd-maiow-bot'
        #end
        
        def config; self.class.config; end
        def events; self.class.events; end
        def configure(*args, &b); self.class.configure(*args, &b); end
        def on(*args, &b); self.class.on(*args, &b); end
        
        # starts a TCP connection.
        def run
            EventMachine::run do
                @tcp = EventMachine::connect(config.server.host, config.server.port, TCPConnection)
                @tcp.client = self
                spectator_join
            end
        end
        
        def send_packet(packet)
            @tcp.send_packet(packet)
        end
        
        def spectator_join
            p = OpenTTD::Packet::TCP.new
            p.opcode = :tcp_client_join
            p.payload.client_version = '1.0.0'
            p.payload.player_name = config.player.name
            p.payload.company = 255
            send_packet(p)
        end
        
        def find_event(opcode)
            handlers = events[opcode] || [nil]
            
            #handlers.select { |criteria, block| :meow == :meow }
            handlers.first
        end
        
        def dispatch_packet_event(packet)
            @payload = packet.payload
            criteria, handler = find_event(packet.opcode)
            
            self.instance_eval(&handler) if handler
            #on_tcp_server_need_password(packet) if packet.opcode == :tcp_server_need_password
        end
        
        # sends 'udp_client_find_server' packet to get server details/settings.
        def query_server_details(server, port = 3979)
            packet = @udp.query(:udp_client_find_server, server, port)
            packet.payload
        end
        
        # sends 'udp_client_detail_info' to get company information.
        def query_server_companies(server, port = 3979)
            packet = @udp.query(:udp_client_detail_info, server, port)
            packet.payload.companies
        end
    end
    
    class TCPConnection < EventMachine::Connection
        attr_accessor :client
        
        def post_init
            puts '-- connecting'
            @in = OpenTTD::Packet::TCP.new
            @buffer = ''
        end
        
        def receive_data(data)
            @buffer << data
            
            packets = OpenTTD::Packet::extract_packets!(@buffer)
            packets.each do |p|
                @in.read(p)
                puts ">> #{@in}"
                @client.dispatch_packet_event(@in)
            end
        end
        
        def unbind
            puts '-- disconnected'
        end
        
        def send_packet(packet)
            puts "<< #{packet}"
            send_data(packet.to_binary_s)
        end
    end
    
    class UDPConnection
        attr_accessor :query_result
        
        def query(opcode, server, port)
            running = EventMachine::reactor_running?
            
            query_server = lambda do
                EventMachine::open_datagram_socket('0.0.0.0', 3979, UDPQuery) do |q|
                    q.udp = self
                    q.should_stop_event_loop = running ? false : true
                    q.send(opcode, server, port)
                end
            end
            
            if running
                query_server.call
            else
                EventMachine::run do
                    query_server.call
                end
            end
            
            query_result
        end
    end
    
    class UDPQuery < EventMachine::Connection
        attr_accessor :udp
        attr_accessor :should_stop_event_loop
        
        def post_init
            @packet = OpenTTD::Packet::UDP.new
            @buffer = ''
        end
        
        def send(opcode, server, port)
            @packet.opcode = opcode
            send_datagram(@packet.to_binary_s, server, port)
        end
        
        def receive_data(data)
            @buffer << data
            
            packets = OpenTTD::Packet::extract_packets!(@buffer)
            @packet.read(packets.first)
            @udp.query_result = @packet
            
            EventMachine.stop_event_loop if should_stop_event_loop
        end
    end
end