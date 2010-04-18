require 'lib/openttd'

class MaiowBot < OpenTTD::Client
    configure do
        server.host = 'kyra.lon.lividpenguin.com'
        player.name = 'maiow'
    end
    
    on :tcp_server_check_newgrfs do
        p = OpenTTD::Packet::TCP.new
        p.opcode = :tcp_client_newgrfs_checked
        send_packet(p)
    end
    
    on :tcp_server_need_password do
        p = OpenTTD::Packet::TCP.new
        p.opcode = :tcp_client_password
        p.payload.password_type = :server
        p.payload.password = 'meowpass'
        send_packet(p)
    end
    
    on :tcp_server_welcome do
        p = OpenTTD::Packet::TCP.new
        p.opcode = :tcp_client_getmap
        p.payload.version = 268979274
        send_packet(p)
    end
    
    on :tcp_server_map do
        if @payload.type == 2
            p = OpenTTD::Packet::TCP.new
            p.opcode = :tcp_client_map_ok
            send_packet(p)
        end
    end
    
    on :tcp_server_frame do
        frame = @payload.frame_count_max
        #ack every 76 frames
        if frame % 76 == 0
            p = OpenTTD::Packet::TCP.new
            p.opcode = :tcp_client_ack
            p.payload.frame = frame
            send_packet(p)
        end
    end
    
    on :tcp_server_chat do
        if @payload.message == 'maiow'
            p = OpenTTD::Packet::TCP.new
            p.opcode = :tcp_client_chat
            p.payload.action_id = :chat
            p.payload.type_id = :broadcast
            p.payload.message = 'purrrrrrrr'
            p.payload.client_id = 0
            send_packet(p)
        end
    end
    
    ## "payload"=>{"action_id"=>:chat_company, "client_id"=>137, "self_sent"=>false, "message"=>"cats say meow", "data"=>0}
    #on :tcp_server_chat do
    #    
    #end
    #
    ## "payload"=>{"action_id"=>:chat, "client_id"=>127, "self_sent"=>false, "message"=>"foobar", "data"=>0}
    #on :tcp_server_chat, :when => { :action_id => :chat } do
    #    
    #end
    #
    ## "payload"=>{"action_id"=>:chat, "client_id"=>127, "self_sent"=>false, "message"=>"meow", "data"=>0}
    #on :tcp_server_chat, :when => { :action_id => :chat, :message => ['moo', 'meow'] } do
    #    
    #end
end

bot = MaiowBot.new
bot.run