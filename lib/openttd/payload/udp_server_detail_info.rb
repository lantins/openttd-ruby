module OpenTTD
    module Payload
        class UdpServerDetailInfo < OpenTTD::Encoding
            uint8 :company_info_version # version of company information were getting
            uint8 :company_count
            
            array :companies, :type => :company_info, :read_until => lambda { index == company_count - 1 }
            
            def has_companies?
                self.company_count > 0
            end
        end
    end
end