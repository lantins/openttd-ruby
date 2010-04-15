module OpenTTD
    module Payload
        class TcpClientSetPassword < OpenTTD::Encoding
            stringz :password_hash
        end
    end
end