require 'eventmachine'
require 'lib/openttd'

module OpenTTD
    class Client < EventMachine::Connection
        def initialize(*args)
            super
            @packet = OpenTTD::Packet::Container.new
        end
        
        def post_init
            @packet.opcode = :client_company_info
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
    EventMachine::connect '10.0.1.200', 3979, OpenTTD::Client
end
