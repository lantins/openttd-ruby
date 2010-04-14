require 'eventmachine'
require 'lib/openttd'

module OpenTTD
    class Client < EventMachine::Connection
        def initialize(*args)
            super
            @packet = OpenTTD::Packet::TCP.new
        end
        
        def post_init
            @packet.opcode = :tcp_client_company_info
            bytes_sent = send_data(@packet.to_binary_s)
        end
        
        def receive_data(data)
            @packet.read(data)
            p @packet
        end
        
        def unbind
            EventMachine::stop_event_loop
        end
    end
end

EventMachine::run do
    EventMachine::connect 'kyra.lon.lividpenguin.com', 3979, OpenTTD::Client
end
