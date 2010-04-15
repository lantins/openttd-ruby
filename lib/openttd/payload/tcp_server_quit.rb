module OpenTTD
    module Payload
        class TcpServerQuit < OpenTTD::Encoding
            uint32le    :client_id
        end
    end
end