require 'eventmachine'
require 'lib/openttd'

class Client < EventMachine::Connection
    def initialize(*args)
        super
        @packet = OpenTTD::Packet::Container.new
    end
    
    def post_init
        puts "connected"
        @packet.opcode = :udp_game_info
        bytes_sent = send_datagram(@packet.to_binary_s, '10.0.1.200', 3979)
    end
    
    def receive_data(data)
        #p data
        @packet.read(data)
        puts @packet
    end
end

EventMachine::run do
    client = EventMachine::open_datagram_socket '0.0.0.0', 3979, Client
end
