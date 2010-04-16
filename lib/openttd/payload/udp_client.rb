module OpenTTD
    module Payload
        class UdpClientGetList < OpenTTD::Encoding
            uint8 :version, :value => OpenTTD::MASTER_SERVER_VERSION
            # we can also send 'server list type' as a uint8; 0 = IPv4; 1 = IPv6; <not set> = autodetect based on connection.
        end
        
        class UdpClientGetNewgrfs < OpenTTD::Encoding
            uint8 :grf_count
            array :grfs, :type => :newgrf
        end
        
        
    end
end