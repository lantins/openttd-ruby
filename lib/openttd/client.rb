module OpenTTD
    class Client
        def initialize(&b)
            @tcp = nil
            @udp = UDPConnection.new
        end
        
        # starts a TCP connection.
        def start
            
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
    
    class TCPClient < EventMachine::Connection
        
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