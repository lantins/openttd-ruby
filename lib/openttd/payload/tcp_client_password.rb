module OpenTTD
    module Payload
        class TcpClientPassword < OpenTTD::Encoding
            uint8 :password_type
            stringz :password
        end
    end
end