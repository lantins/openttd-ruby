module OpenTTD
    module Payload
        class UdpMasterResponseList < OpenTTD::Encoding
            uint8 :version
            uint16le :server_count
            
            array :servers, :type => :server_address, :read_until => lambda { index == server_count - 1 }
        end
        
        class UdpServerDetailInfo < OpenTTD::Encoding
            uint8 :company_info_version # version of company information were getting
            uint8 :company_count
            
            array :companies, :type => :company_info, :read_until => lambda { index == company_count - 1 }
            
            def has_companies?
                self.company_count > 0
            end
        end
        
        class UdpServerResponse < OpenTTD::Encoding
            uint8 :game_info_version # version of game information were getting
            uint8 :grf_count # number of grf packs
            array :grfs, :type => :newgrf, :read_until => lambda { index == grf_count - 1 }, :onlyif => :custom_grfs? 
            uint32le :current_date # date in days since 1-1-0 (DMY)
            uint32le :start_date # date in days since 1-1-0 (DMY)
            uint8 :companies_max
            uint8 :companies_on
            uint8 :spectators_max
            stringz :server_name
            stringz :server_revision
            uint8 :server_lang
            uint8 :use_password
            uint8 :clients_max
            uint8 :clients_on
            uint8 :spectators_on
            stringz :map_name
            uint16le :map_width
            uint16le :map_height
            uint8 :map_set
            uint8 :dedicated
            
            boolean_encoding :protected, :dedicated
            openttd_date :current_date, :start_date
            
            def custom_grfs?
                self.grf_count > 0
            end
        end
    end
end