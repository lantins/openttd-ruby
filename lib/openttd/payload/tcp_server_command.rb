module OpenTTD
    module Payload
        class TcpServerCommand < OpenTTD::Encoding
            uint8    :company_id
            uint32le :command
            uint32le :p1
            uint32le :p2
            uint32le :tile
            stringz  :text
            uint8    :callback
            uint32le :frame
            uint8    :self_send
            
            boolean_encoding :self_send
        end
    end
end