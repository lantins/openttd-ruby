module OpenTTD
    module Payload
        class UdpMasterResponseList < OpenTTD::Encoding
            uint8 :version
            uint16le :server_count
            
            array :servers, :type => :server_address, :read_until => lambda { index == server_count - 1 }
        end
    end
end