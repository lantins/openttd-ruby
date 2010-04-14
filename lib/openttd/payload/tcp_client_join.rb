module OpenTTD
    module Payload
        class TcpClientJoin < OpenTTD::Encoding
            stringz :client_version
            stringz :player_name
            uint8   :company
            uint8   :language
            stringz :network_id
        end
    end
end