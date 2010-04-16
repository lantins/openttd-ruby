require 'eventmachine'
require 'lib/openttd'

class TestClient < EventMachine::Connection
    def initialize(*args)
        super
        @packet = OpenTTD::Packet::UDP.new
        @buffer = ''
    end
    
    def post_init
        puts "connected"
        @packet.opcode = :udp_client_find_server
        bytes_sent = send_datagram(@packet.to_binary_s, 'kyra.lon.lividpenguin.com', 3979)
        #bytes_sent = send_datagram(@packet.to_binary_s, OpenTTD::MASTER_SERVER_HOST, OpenTTD::MASTER_SERVER_PORT)
    end
    
    def receive_data(data)
        @buffer << data
        
        packets = OpenTTD::Packet::extract_packets!(@buffer)
        packets.each do |p|
            @packet.read(p)
            p @packet
        end
    end
end

EventMachine::run do
    client = EventMachine::open_datagram_socket '0.0.0.0', 3979, TestClient
end
