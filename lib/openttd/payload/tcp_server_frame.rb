module OpenTTD
    module Payload
        class TcpServerFrame < OpenTTD::Encoding
            uint32le :frame_count
            uint32le :frame_count_max
            rest :data  #incase of seed data
            #uint32le :seed1 #server define "ENABLE_NETWORK_SYNC_EVERY_FRAME"
            #uint32le :seed2 #server define "NETWORK_SEND_DOUBLE_SEED"            
        end
    end
end