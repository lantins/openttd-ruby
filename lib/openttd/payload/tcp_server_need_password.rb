module OpenTTD
    module Payload
        class TcpServerNeedPassword < OpenTTD::Encoding
            uint8 :type
            uint32le :seed
            stringz  :network_id
        end
    end
end