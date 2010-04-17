require 'lib/openttd'

#class MeowBot < OpenTTD::Client
#    configure do
#        server.host = 'kyra.lon.lividpenguin.com'
#        player.name = 'ottd-maiow-bot'
#    end
#    
#    on :tcp_server_need_password do
#        p = OpenTTD::Packet::TCP.new
#        p.opcode = :tcp_client_password
#        p.payload.password_type = :server
#        p.payload.password = 'meowpass'
#        send_packet(p)
#    end
#    
#    ## "payload"=>{"action_id"=>:chat_company, "client_id"=>137, "self_sent"=>false, "message"=>"cats say meow", "data"=>0}
#    #on :tcp_server_chat do
#    #    
#    #end
#    #
#    ## "payload"=>{"action_id"=>:chat, "client_id"=>127, "self_sent"=>false, "message"=>"foobar", "data"=>0}
#    #on :tcp_server_chat, :when => { :action_id => :chat } do
#    #    
#    #end
#    #
#    ## "payload"=>{"action_id"=>:chat, "client_id"=>127, "self_sent"=>false, "message"=>"meow", "data"=>0}
#    #on :tcp_server_chat, :when => { :action_id => :chat, :message => ['moo', 'meow'] } do
#    #    
#    #end
#end

# callbacks and logic defined in your sub-class.
bot = OpenTTD::Client.new do
    configure do |c|
        c.server.host = 'kyra.lon.lividpenguin.com'
        c.player.name = 'ottd-maiow-bot'
    end
    
    on :tcp_server_need_password do
        p = OpenTTD::Packet::TCP.new
        p.opcode = :tcp_client_password
        p.payload.password_type = :server
        p.payload.password = 'meowpass'
        send_packet(p)
    end
end

bot.run

## or ...
#client = OpenTTD::Client.new do
#    # define callbacks and logic.
#    
#    on :tcp_server_chat do
#        # something...
#    end
#end
#client.connect