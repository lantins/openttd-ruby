module OpenTTD
    module Payload
        class UdpClientGetNewgrfs < OpenTTD::Encoding
            uint8 :grf_count
            array :grfs, :type => :newgrf
        end
    end
end