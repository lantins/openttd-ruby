module OpenTTD
    module Payload
        class TcpServerWait < OpenTTD::Encoding
            uint8 :waiting
        end
    end
end