module OpenTTD
    module Payload
        class TcpClientCommand < OpenTTD::Encoding
            uint8   :comapny_id
            uint32le :command_id
            uint32le :p1
            uint32le :p2
            uint32le :tile
            stringz :text
            uint8 :callback_id
        end
    end
end