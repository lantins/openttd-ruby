require 'lib/openttd'

require 'json'

request = OpenTTD::Packet::Container.new
request.opcode = :udp_game_info

puts "REQUEST"
p request.to_binary_s
p request

#puts "RESPONCE"
#responce = OpenTTD::Packet::Container.new
#responce.read "O\x00\x05\x06\x01\x00p3p Transport\x00\xB0\a\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x0F/\x01\x00\x00\x00\x00\x00<\xF6\xFF\xFF\xFF\xFF\xFF\xFF\x1E\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00<none>\x00\x05\x00\x05\x06\x00"
##puts JSON.pretty_generate(responce.snapshot)
#
#p responce.to_binary_s
#p responce.payload.name = 'Paws Logistics'
#p responce.to_binary_s
#

#data = OpenTTD::Packet::Container.new
#data.opcode = :server_company_info
#puts JSON.pretty_generate(data.snapshot)
#p data.to_binary_s