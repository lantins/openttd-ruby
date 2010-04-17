$:.unshift(File.expand_path(File.dirname(__FILE__))) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'payload/tcp_client'
require 'payload/tcp_server'
require 'payload/udp_client'
require 'payload/udp_server'

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
        
        CHAT_ENCODING_MAP = {
            :action_id => {
                0 => :join,
                1 => :leave,
                2 => :server_message,
                3 => :chat,
                4 => :chat_company,
                5 => :chat_client,
                6 => :give_money,
                7 => :name_change,
                8 => :company_spectator,
                9 => :company_join,
                10 => :company_new
            },
            :type_id => {
                0 => :broadcast,
                1 => :team,
                2 => :private
            }
        }
        
        ERROR_ENCODING_MAP = {
            :error_code => {
                0 => :general,
                1 => :desync,
                2 => :savegame_failed,
                3 => :connection_lost,
                4 => :illegal_packet,
                5 => :newgrf_mismatch,
                6 => :not_authorized,
                7 => :not_expected,
                8 => :wrong_revision,
                9 => :name_in_use,
                10 => :wrong_password,
                11 => :player_mismatch,
                12 => :kicked,
                13 => :cheater,
                14 => :full
            }
        }
        
        PASSWORD_TYPE_ENCODING_MAP = {
            :password_type => {
                0 => :server,
                1 => :company
            }
        }
    end
end