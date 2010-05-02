require 'lib/openttd'

class MaiowBot < OpenTTD::Client
    configure do
        server.host = 'kyra.lon.lividpenguin.com'
        player.name = 'maiow'
    end
    
    on :tcp_server_check_newgrfs do
        send_packet :tcp_client_newgrfs_checked
    end
    
    on :tcp_server_need_password do
        send_packet :tcp_client_password do |pl|
            pl.password_type = :server
            pl.password = 'meowpass'
        end
    end
    
    on :tcp_server_welcome do
        send_packet :tcp_client_getmap do |pl|
            pl.version = 268979274
        end
    end
    
    on :tcp_server_map do
        if @payload.type == 2
            send_packet :tcp_client_map_ok
        end
    end
    
    on :tcp_server_frame do
        frame = @payload.frame_count_max
        #ack every 76 frames
        if frame % 76 == 0
            send_packet :tcp_client_ack do |pl|
                pl.frame = frame
            end
        end
    end
    
    on :tcp_server_chat, :action_id => :chat, :message => 'maiow' do
        send_packet :tcp_client_chat do |pl|
            pl.action_id = :chat
            pl.type_id = :broadcast
            pl.message = 'purrrrrrrr'
            pl.client_id = 0
        end
    end
    
    on :tcp_server_chat, :action_id => :chat, :message => 'yo yo' do
        send_packet :tcp_client_chat do |pl|
            pl.action_id = :chat
            pl.type_id = :broadcast
            pl.message = 'meowww maiow'
            pl.client_id = 0
        end
    end
    
    # FIXME: allow regex comparison, could we pass matches too?
    on :tcp_server_chat, :action_id => :chat, :message => /^(foo|bar)$/ do
        send_packet :tcp_client_chat do |pl|
            pl.action_id = :chat
            pl.type_id = :broadcast
            pl.message = @payload.message == 'foo' ? 'barfoo' : 'foobar'
            pl.client_id = 0
        end
    end
    
    # FIXME: allow array comparison (kinda like as IN() in SQL).
    on :tcp_server_chat, :action_id => :chat, :message => ['cats', 'tigers', 'lions'] do
        send_packet :tcp_client_chat do |pl|
            pl.action_id = :chat
            pl.type_id = :broadcast
            pl.message = 'i think they rule!'
            pl.client_id = 0
        end
    end
    
    ## "payload"=>{"action_id"=>:chat, "client_id"=>127, "self_sent"=>false, "message"=>"meow", "data"=>0}
    #on :tcp_server_chat, :when => { :action_id => :chat, :message => ['moo', 'meow'] } do
    #    
    #end
end

bot = MaiowBot.new
bot.run