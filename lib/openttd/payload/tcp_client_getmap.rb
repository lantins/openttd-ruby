module OpenTTD
    module Payload
        class TcpClientGetmap < OpenTTD::Encoding
            uint32le    :version
        end
    end
end