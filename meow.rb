require 'lib/openttd'

#class MeowClient < OpenTTD::Client
#    def initialize
#        super
#    end
#    
#    # "payload"=>{"action_id"=>:chat_company, "client_id"=>137, "self_sent"=>false, "message"=>"cats say meow", "data"=>0}
#    on :tcp_server_chat do
#        
#    end
#    
#    # "payload"=>{"action_id"=>:chat, "client_id"=>127, "self_sent"=>false, "message"=>"foobar", "data"=>0}
#    on :tcp_server_chat, :when => { :action_id => :chat } do
#        
#    end
#    
#    # "payload"=>{"action_id"=>:chat, "client_id"=>127, "self_sent"=>false, "message"=>"meow", "data"=>0}
#    on :tcp_server_chat, :when => { :action_id => :chat, :message => ['moo', 'meow'] } do
#        
#    end
#end
#
## callbacks and logic defined in your sub-class.
#client = MeowClient.new
#client.connect
#
## or ...
#client = OpenTTD::Client.new do
#    # define callbacks and logic.
#    
#    on :tcp_server_chat do
#        # something...
#    end
#end
#client.connect
#
## get servers from master server.
#client.master.servers
#
## query a spesific server.
#client.game_info 'kyra.lon.lividpenguin.com', 9999
#client.detail_info 'kyra.lon.lividpenguin.com', 9999

client = OpenTTD::Client.new
#result = client.query_server_details 'kyra.lon.lividpenguin.com'
#p result
result = client.query_server_companies 'kyra.lon.lividpenguin.com'
p result