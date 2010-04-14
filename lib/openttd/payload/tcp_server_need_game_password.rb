module OpenTTD
    module Payload
        class TcpServerNeedGamePassword < OpenTTD::Encoding
            uint8 :type
            uint32le :seed
            stringz  :network_id
        end
    end
end