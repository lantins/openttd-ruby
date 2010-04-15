module OpenTTD
    module Payload
        class TcpServerMove < OpenTTD::Encoding
            uint32le    :client_id
            uint8       :company_id
        end
    end
end