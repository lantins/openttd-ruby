$:.unshift(File.expand_path(File.dirname(__FILE__))) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'payload/tcp_server_company_info'
require 'payload/tcp_client_join'
require 'payload/tcp_server_error'
require 'payload/tcp_server_need_password'
require 'payload/tcp_client_game_password'
require 'payload/udp_client_get_list'
require 'payload/udp_master_response_list'
require 'payload/udp_server_detail_info'
require 'payload/udp_server_response'

module OpenTTD
    module Payload
        class Empty < OpenTTD::Encoding; end
        
        class TcpServerFull < Empty; end
        class TcpClientCompanyInfo < Empty; end
        
        class UdpClientDetailInfo < Empty; end
        class UdpClientFindServer < Empty; end
    end
end