module OpenTTD
    module Payload
        class TcpServerConfigUpdate < OpenTTD::Encoding
            uint8   :max_companies
            uint8   :max_spectators
        end
    end
end