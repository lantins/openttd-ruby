module OpenTTD
    module DataType
        class CompanyInfo < OpenTTD::Encoding
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
            
            #rest :foo
            
            boolean_encoding :protected, :is_ai
        end
    end
end