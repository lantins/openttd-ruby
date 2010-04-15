module OpenTTD
    module Payload
        class TcpServerJoin < OpenTTD::Encoding
            uint32le    :client_id
        end
    end
end