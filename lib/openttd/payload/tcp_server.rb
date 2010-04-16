module OpenTTD
    module Payload
        class TcpServerChat < OpenTTD::Encoding
            uint8    :action_id
            uint32le :client_id
            uint8    :self_sent
            stringz  :message
            uint64le :data
            
            boolean_encoding :self_sent
            lookup_encoding :action_id
            
            def encodeing_lookup_map
                CHAT_ENCODING_MAP
            end
        end
        
        class TcpServerCheckNewgrfs < OpenTTD::Encoding
            uint8 :grf_count
            array :grfs, :type => :newgrf, :read_until => lambda { index == grf_count - 1 }, :onlyif => :custom_grfs?
            
            def custom_grfs?
                self.grf_count > 0
            end
        end
        
        class TcpServerClientInfo < OpenTTD::Encoding
            uint32le :client_id
            uint8    :company_id
            stringz  :name
        end
        
        class TcpServerCommand < OpenTTD::Encoding
            uint8    :company_id
            uint32le :command
            uint32le :p1
            uint32le :p2
            uint32le :tile
            stringz  :text
            uint8    :callback
            uint32le :frame
            uint8    :self_send
            
            boolean_encoding :self_send
        end
        
        class TcpServerCompanyInfo < OpenTTD::Encoding
            uint8 :info_version # version of information were getting
            uint8 :last_packet # is this the last packet of information?
            
            company_info :company_info
            
            stringz :clients
        end
        
        class TcpServerCompanyUpdate < OpenTTD::Encoding
            uint16le    :passworded
        end
        
        class TcpServerConfigUpdate < OpenTTD::Encoding
            uint8   :max_companies
            uint8   :max_spectators
        end
        
        class TcpServerError < OpenTTD::Encoding
            uint8 :error_code
        end
        
        class TcpServerErrorQuit < OpenTTD::Encoding
            uint32le :client_id
            uint8 :error_code
        end
        
        class TcpServerFrame < OpenTTD::Encoding
            uint32le :frame_count
            uint32le :frame_count_max
            rest :data  #incase of seed data
            #uint32le :seed1 #server define "ENABLE_NETWORK_SYNC_EVERY_FRAME"
            #uint32le :seed2 #server define "NETWORK_SEND_DOUBLE_SEED"
        end
        
        class TcpServerJoin < OpenTTD::Encoding
            uint32le    :client_id
        end
        
        class TcpServerMap < OpenTTD::Encoding
            uint8 :type
            
            uint32le :frame_count, :onlyif => :start_data?
            uint32le :position, :onlyif => :start_data?
            
            rest :data, :onlyif => :data?
            
            def start_data?
                self.type == 0
            end
            
            def data?
                self.type == 1
            end
            
            def end_data?
                self.type == 2
            end
        end
        
        class TcpServerMove < OpenTTD::Encoding
            uint32le    :client_id
            uint8       :company_id
        end
        
        class TcpServerNeedPassword < OpenTTD::Encoding
            uint8 :type
            uint32le :seed
            stringz  :network_id
        end
        
        class TcpServerQuit < OpenTTD::Encoding
            uint32le    :client_id
        end
        
        class TcpServerRcon < OpenTTD::Encoding
            uint16le :colour
            stringz :rcon
        end
        
        class TcpServerSync < OpenTTD::Encoding
            uint32le    :frame
            uint32le    :seed
        end
        
        class TcpServerWait < OpenTTD::Encoding
            uint8 :waiting
        end
        
        class TcpServerWelcome < OpenTTD::Encoding
            uint32le    :client_id
            uint32le    :seed
            stringz     :network_id
        end
    end
end