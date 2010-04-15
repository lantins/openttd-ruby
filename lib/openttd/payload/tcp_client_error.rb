module OpenTTD
    module Payload
        class TcpClientError < OpenTTD::Encoding
            uint8 :error_code
        end
    end
end