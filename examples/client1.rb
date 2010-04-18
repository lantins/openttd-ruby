require 'lib/openttd'

client = OpenTTD::Client.new

client.configure do
    server.host = 'kyra.lon.lividpenguin.com'
end

client.on :tcp_server_need_password do
    p = OpenTTD::Packet::TCP.new
    p.opcode = :tcp_client_password
    p.payload.password_type = :server
    p.payload.password = 'meowpass'
    send_packet(p)
end

client.run