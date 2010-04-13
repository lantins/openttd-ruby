module OpenTTD
    module Payload
        class UdpServerGameInfo < OpenTTD::Encoding
            uint8 :info_version # version of information were getting
            uint8 :grf_count, :value => lambda { self.grf_names.length } # number of grf packs
            array :grf_names, :type => [:string, {:length => 20}], :read_until => lambda { self.grf_count }
            uint32le :date
            uint32le :date2
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
        end
    end
end