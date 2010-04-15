module OpenTTD
    module Payload
        class TcpClientAck < OpenTTD::Encoding
            uint32le :frame
        end
    end
end