$:.unshift(File.expand_path(File.dirname(__FILE__))) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'payload/server_company_info'
require 'payload/udp_server_game_info.rb'

module OpenTTD
    module Payload
        class Empty < OpenTTD::Encoding; end
        class ClientCompanyInfo < Empty; end
        class UdpGameInfo < Empty; end
    end
end