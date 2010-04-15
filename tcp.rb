require 'eventmachine'
require 'lib/openttd'

class TestClient < EventMachine::Connection
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
        bytes_sent = send_data(@packet.to_binary_s)
    end
    
    def receive_data(data)
        @buffer << data
        
        while @buffer.length >= OpenTTD::Packet::MIN_LENGTH
             
            length = @buffer[0, 2].unpack('S').first
            return unless @buffer.length >= length

            @packet.read(@buffer.slice! 0..length - 1)
            
            case
            when @packet.opcode == :tcp_server_check_newgrfs
                @packet.opcode = :tcp_client_newgrfs_checked
                bytes_sent = send_data(@packet.to_binary_s)                
            
            when @packet.opcode == :tcp_server_need_password
                @packet.opcode = :tcp_client_password
                @packet.payload.password_type = 0
                @packet.payload.password = 'temp'
                bytes_sent = send_data(@packet.to_binary_s)
            
            when @packet.opcode == :tcp_server_welcome
                @tmpClientId = @packet.payload.client_id
                @packet.opcode = :tcp_client_getmap
                @packet.payload.version = 268979274
                bytes_sent = send_data(@packet.to_binary_s)
           
            when @packet.opcode == :tcp_server_chat
                case
                when @packet.payload.message == "moo"
                    @packet.opcode = :tcp_client_chat
                    @packet.payload.action_id = 3
                    @packet.payload.type_id = 0
                    @packet.payload.message = 'rar'
                    @packet.payload.client_id = 0
                    bytes_sent = send_data(@packet.to_binary_s)
                when @packet.payload.message == "quit"
                    @packet.opcode = :tcp_client_quit
                    bytes_sent = send_data(@packet.to_binary_s)
                when @packet.payload.message == "newname"
                    @packet.opcode = :tcp_client_set_name
                    @packet.payload.name = 'shutityou'
                    bytes_sent = send_data(@packet.to_binary_s)
                when @packet.payload.message == "whisperme"
                    @clientfrom = @packet.payload.client_id
                    @packet.opcode = :tcp_client_chat
                    @packet.payload.client_id = @clientfrom
                    @packet.payload.message = "what?"
                    @packet.payload.type_id = 2
                    @packet.payload.action_id = 5
                    bytes_sent = send_data(@packet.to_binary_s)
                when @packet.payload.message == "teamsay"
                    @packet.opcode = :tcp_client_chat
                    @packet.payload.client_id = 255
                    @packet.payload.message = "what?"
                    @packet.payload.type_id = 1
                    @packet.payload.action_id = 4
                    bytes_sent = send_data(@packet.to_binary_s)
                when @packet.payload.message == "joinme"
                    @packet.opcode = :tcp_client_move
                    @packet.payload.company = 0
                    @packet.payload.password_hash = ''
                    bytes_sent = send_data(@packet.to_binary_s)
                end
           
            when @packet.opcode == :tcp_server_map
                if @packet.payload.type == 2
                    @packet.opcode = :tcp_client_map_ok
                    bytes_sent = send_data(@packet.to_binary_s)
                end
            
            when @packet.opcode == :tcp_server_frame
                @frame = @packet.payload.frame_count_max
                #ack every 76 frames
                if @frame % 76 == 0
                    @packet.opcode = :tcp_client_ack
                    @packet.payload.frame = @frame
                    bytes_sent = send_data(@packet.to_binary_s)
                end
            
            else p @packet #print unprocessed packets
            end
        end
    end
    
    def unbind
        EventMachine::stop_event_loop
    end
end

EventMachine::run do
    #EventMachine::connect 'kyra.lon.lividpenguin.com', 3979, OpenTTD::Client
    EventMachine::connect '10.0.1.100', 3979, TestClient
end
