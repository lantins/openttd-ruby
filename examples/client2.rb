require 'lib/openttd'

client = OpenTTD::Client.new do
    configure do
        server.host = 'kyra.lon.lividpenguin.com'
        player.name = 'meow'
    end
    
    on :tcp_server_need_password do
        send_packet :tcp_client_password do |pl|
            pl.password_type = :server
            pl.password = 'meowpass'
        end
    end
end

client.run