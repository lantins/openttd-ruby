module OpenTTD
    module Payload
        class TcpServerCompanyInfo < OpenTTD::Encoding
            uint8 :info_version # version of information were getting
            uint8 :last_packet # is this the last packet of information?
            
            company_info :company_info
            
            stringz :clients
        end
    end
end