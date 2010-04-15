module OpenTTD
    module Payload
        class TcpServerCompanyUpdate < OpenTTD::Encoding
            uint16le    :passworded
        end
    end
end