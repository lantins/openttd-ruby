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
        puts "connecting\n"
    end
    
    def receive_data(data)
        @buffer << data
        
        while @buffer.length >= OpenTTD::Packet::MIN_LENGTH
             
            length = @buffer[0, 2].unpack('S').first
            return unless @buffer.length >= length


            @packet.read(@buffer.slice! 0..length - 1)
            

            if @packet.opcode == :tcp_server_check_newgrfs
                puts "server asks to check newgrfs\n"
                @packet.opcode = :tcp_client_newgrfs_checked
                bytes_sent = send_data(@packet.to_binary_s)
            else

                if @packet.opcode == :tcp_server_need_password
                    puts "Send Password\n"
                    @packet.opcode = :tcp_client_password
                    @packet.payload.password_type = 0
                    @packet.payload.password = 'temp'
                    bytes_sent = send_data(@packet.to_binary_s)
                else

                    if @packet.opcode == :tcp_server_welcome
                        puts "the server welcomes us\n"
                        @tmpClientId = @packet.payload.client_id
                        
                        @packet.opcode = :tcp_client_getmap
                        @packet.payload.version = 268979274
                        bytes_sent = send_data(@packet.to_binary_s)
                    else
                        if  @packet.opcode == :tcp_server_chat
                            if @packet.payload.message == "moo"
                                @packet.opcode = :tcp_client_chat
                                @packet.payload.action_id = 3
                                @packet.payload.type_id = 0
                                @packet.payload.message = 'rar'
                                @packet.payload.client_id = 0
                                bytes_sent = send_data(@packet.to_binary_s)
                            end
                        else
                            if @packet.opcode == :tcp_server_map
                                if @packet.payload.type == 2
                                    @packet.opcode = :tcp_client_map_ok
                                    bytes_sent = send_data(@packet.to_binary_s)
                                end
                            else
                                if @packet.opcode == :tcp_server_frame
                                    @frame = @packet.payload.frame_count_max
                                    if @frame % 76 == 0
                                        @packet.opcode = :tcp_client_ack
                                        @packet.payload.frame = @frame
                                        bytes_sent = send_data(@packet.to_binary_s)
                                        p @packet
                                    end
                                else
                                    p @packet
                                end
                            end
                        end
                    end
                end
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
