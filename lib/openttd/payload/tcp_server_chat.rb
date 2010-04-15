module OpenTTD
    module Payload
        class TcpServerChat < OpenTTD::Encoding
            uint8    :action_id
            uint32le :client_id
            uint8    :self_sent
            stringz  :message
            uint64le :data
            
            boolean_encoding :self_sent
        end
    end
end