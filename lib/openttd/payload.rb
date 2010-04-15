$:.unshift(File.expand_path(File.dirname(__FILE__))) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'payload/tcp_server_company_info'
require 'payload/tcp_client_join'
require 'payload/tcp_server_error'
require 'payload/tcp_server_error_quit'
require 'payload/tcp_server_check_newgrfs'
require 'payload/tcp_server_need_password'
require 'payload/tcp_client_password'
require 'payload/tcp_server_welcome'
require 'payload/tcp_server_client_info'
require 'payload/tcp_client_getmap'
require 'payload/tcp_server_wait'
require 'payload/tcp_server_map'
require 'payload/tcp_server_frame'
require 'payload/tcp_client_ack'
require 'payload/tcp_server_sync'
require 'payload/tcp_server_join'
require 'payload/tcp_server_config_update'
require 'payload/tcp_server_company_update'
require 'payload/tcp_server_command'
require 'payload/tcp_client_command'
require 'payload/tcp_server_chat'
require 'payload/tcp_client_chat'
require 'payload/tcp_client_error'
require 'payload/tcp_server_quit'
require 'payload/tcp_server_rcon'
require 'payload/tcp_server_move'
require 'payload/tcp_client_set_password'
require 'payload/tcp_client_set_name'
require 'payload/tcp_client_rcon'
require 'payload/tcp_client_move'
require 'payload/udp_client_get_list'
require 'payload/udp_master_response_list'
require 'payload/udp_server_detail_info'
require 'payload/udp_server_response'

module OpenTTD
    module Payload
        class Empty < OpenTTD::Encoding; end
        
        class TcpServerFull < Empty; end
        class TcpServerBanned < Empty; end

        class TcpClientCompanyInfo < Empty; end
        class TcpClientNewgrfsChecked < Empty; end
        class TcpClientMapOk < Empty; end
        class TcpClientQuit < Empty; end

        class TcpServerShutdown < Empty; end
        class TcpServerNewgame < Empty; end

        class UdpClientDetailInfo < Empty; end
        class UdpClientFindServer < Empty; end
    end
end