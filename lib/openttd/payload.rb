$:.unshift(File.expand_path(File.dirname(__FILE__))) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'payload/tcp_server_company_info'
require 'payload/udp_server_response'

module OpenTTD
    module Payload
        class Empty < OpenTTD::Encoding; end
        class TcpServerFull < Empty; end
        class TcpClientCompanyInfo < Empty; end
        class UdpClientFindServer < Empty; end
    end
end