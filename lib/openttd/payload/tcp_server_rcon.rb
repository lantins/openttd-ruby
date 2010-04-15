module OpenTTD
    module Payload
        class TcpServerRcon < OpenTTD::Encoding
            uint16le :colour
            stringz :rcon
        end
    end
end