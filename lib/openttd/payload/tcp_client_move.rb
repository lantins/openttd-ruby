module OpenTTD
    module Payload
        class TcpClientMove < OpenTTD::Encoding
            uint8 :company
            stringz :password_hash
        end
    end
end