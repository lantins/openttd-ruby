require 'eventmachine'
require 'lib/openttd'

module OpenTTD
    class Client < EventMachine::Connection
        def initialize(*args)
            super
            @packet = OpenTTD::Packet::TCP.new
            @buffer = ''
        end
        
        def post_init
            @packet.opcode = :tcp_client_join
            
            @packet.payload.client_version = '1.0.0'
            @packet.payload.player_name = 'bobbit'
            @packet.payload.company = 255
            @packet.payload.network_id = 'a4782bf24f3cc3ff747843f992f19fb40'

            p @packet
            
            bytes_sent = send_data(@packet.to_binary_s)
        end
        
        def receive_data(data)
            @buffer << data
            
            return unless @buffer.length >= OpenTTD::Packet::MIN_LENGTH
            length = @buffer[0, 2].unpack('S').first
            return unless @buffer.length >= length
            
            @packet.read(@buffer)
            @buffer.slice! 0..@packet.num_bytes - 1

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
