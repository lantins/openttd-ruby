module OpenTTD
    module Payload
        class TcpServerWelcome < OpenTTD::Encoding
            uint32le    :client_id
            uint32le    :seed
            stringz     :network_id
        end
    end
end