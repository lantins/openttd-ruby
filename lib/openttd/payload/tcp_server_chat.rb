module OpenTTD
    module Payload
        class TcpServerChat < OpenTTD::Encoding
            uint8    :action_id
            uint32le :client_id
            int8     :self_sent
            stringz  :message
            uint64le :data
        end
    end
end