module OpenTTD
    module Payload
        class TcpClientChat < OpenTTD::Encoding
            uint8    :action_id
            uint8    :type_id
            uint32le :client_id
            stringz  :message
            uint64le :data
        end
    end
end