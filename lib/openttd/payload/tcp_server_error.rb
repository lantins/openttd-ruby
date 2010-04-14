module OpenTTD
    module Payload
        class TcpServerError < OpenTTD::Encoding
            uint8 :error_code
        end
    end
end