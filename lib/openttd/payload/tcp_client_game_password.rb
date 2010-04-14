module OpenTTD
    module Payload
        class TcpClientGamePassword < OpenTTD::Encoding
            uint8 :password_type
            stringz :password
        end
    end
end