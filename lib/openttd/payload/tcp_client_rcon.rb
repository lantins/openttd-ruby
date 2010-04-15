module OpenTTD
    module Payload
        class TcpClientRcon < OpenTTD::Encoding
            stringz :password
            stringz :command
        end
    end
end