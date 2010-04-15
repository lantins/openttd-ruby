module OpenTTD
    module Payload
        class TcpServerMap < OpenTTD::Encoding
            uint8 :type
            
            uint32le :frame_count, :onlyif => :start_data?
            uint32le :position, :onlyif => :start_data?
            
            rest :data, :onlyif => :data?
            
            
            
            
            def start_data?
                self.type == 0
            end
           
            def data?
                self.type == 1
            end
            
            def end_data?
                self.type == 2
            end
            
        end
    end
end