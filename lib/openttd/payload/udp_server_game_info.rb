module OpenTTD
    module Payload
        class UdpServerGameInfo < OpenTTD::Encoding
            uint8 :info_version # version of information were getting
            uint8 :grf_count, :value => lambda { self.grf_names.length } # number of grf packs
            array :grf_names, :type => [:string, {:length => 20}], :read_until => lambda { self.grf_count }, :onlyif => :custom_grfs?
            uint32le :game_date # date in days since 1-1-0 (DMY)
            uint32le :state_date # date in days since 1-1-0 (DMY)
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
            
            boolean_encoding :use_password, :dedicated
            
            def custom_grfs?
                self.grf_count > 0
            end
            
            def game_date
                Date.new(0, 1, 1, Date::GREGORIAN) + find_obj_for_name(:game_date).value
            end
            
            def state_date
                Date.new(0, 1, 1, Date::GREGORIAN) + find_obj_for_name(:state_date).value
            end
        end
    end
end