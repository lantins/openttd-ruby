require 'eventmachine'
require 'lib/openttd'

class Client < EventMachine::Connection
    def initialize(*args)
        super
        @packet = OpenTTD::Packet::UDP.new
        @buffer = ''
    end
    
    def post_init
        puts "connected"
        @packet.opcode = :udp_client_get_list
        #bytes_sent = send_datagram(@packet.to_binary_s, 'kyra.lon.lividpenguin.com', 3979)
        bytes_sent = send_datagram(@packet.to_binary_s, OpenTTD::MASTER_SERVER_HOST, OpenTTD::MASTER_SERVER_PORT)
    end
    
    def receive_data(data)
        @buffer << data
        
        while @buffer.length >= OpenTTD::Packet::MIN_LENGTH
            length = @buffer[0, 2].unpack('S').first
            return unless @buffer.length >= length
            
            @packet.read(@buffer)
            @buffer.slice! 0..@packet.num_bytes - 1
            
            p @packet
        end
    end
end

EventMachine::run do
    client = EventMachine::open_datagram_socket '0.0.0.0', 3979, Client
end
