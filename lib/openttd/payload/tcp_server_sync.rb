module OpenTTD
    module Payload
        class TcpServerSync < OpenTTD::Encoding
            uint32le    :frame
            uint32le    :seed
        end
    end
end