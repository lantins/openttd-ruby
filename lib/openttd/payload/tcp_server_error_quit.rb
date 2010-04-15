module OpenTTD
    module Payload
        class TcpServerErrorQuit < OpenTTD::Encoding
            uint32le :client_id
            uint8 :error_code
        end
    end
end