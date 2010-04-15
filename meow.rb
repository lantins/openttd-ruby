require 'lib/openttd'

class MeowClient < OpenTTD::Client
    def initialize
        super
    end
    
    on :tcp_server_chat do
        # something
    end
end

# callbacks and logic defined in your sub-class.
client = MeowClient.new
client.connect

# or ...
client = OpenTTD::Client.new do
    # define callbacks and logic.
    
    on :tcp_server_chat do
        # something...
    end
end
client.connect

# get servers from master server.
client.master.servers

# query a spesific server.
client.game_info 'kyra.lon.lividpenguin.com', 9999
client.detail_info 'kyra.lon.lividpenguin.com', 9999