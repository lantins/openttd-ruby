module OpenTTD
    module Payload
        class TcpServerClientInfo < OpenTTD::Encoding
            uint32le :client_id
            uint8    :company_id
            stringz  :name
        end
    end
end