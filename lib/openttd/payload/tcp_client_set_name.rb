module OpenTTD
    module Payload
        class TcpClientSetName < OpenTTD::Encoding
            stringz :name
        end
    end
end