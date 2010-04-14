module OpenTTD
    module Payload
        class TcpServerCheckNewgrfs < OpenTTD::Encoding
            uint8 :grf_count
            array :grfs, :type => :newgrf, :read_until => lambda { index == grf_count - 1 }, :onlyif => :custom_grfs?

            def custom_grfs?
                self.grf_count > 0
            end

        end
    end
end