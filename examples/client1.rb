require 'lib/openttd'

client = OpenTTD::Client.new

client.configure do
  server.host = 'kyra.lon.lividpenguin.com'
end

client.on :tcp_server_need_password do
  send_packet :tcp_client_password do |pl|
    pl.password_type = :server
    pl.password = 'meowpass'
  end
end

client.run