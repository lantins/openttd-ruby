module OpenTTD
    module Payload
        class ServerCompanyInfo < OpenTTD::Encoding
            uint8 :info_version # version of information were getting
            uint8 :last_packet # is this the last packet of information?
            uint8 :id
            
            stringz :name
            uint32le :created_year
            int64le :worth
            int64le :money
            int64le :income
            uint16le :performance
            uint8le :protected
            string :vehicles, :length => 10 # trains, trucks, busses, plains, boats
            string :stations, :length => 10
            uint8le :is_ai
            stringz :clients
        end
    end
end