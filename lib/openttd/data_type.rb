module OpenTTD
  ##
  # This module contains 'data types' for use with the BinData Record's.
  module DataType
    class CompanyInfo < OpenTTD::Encoding
      uint8 :id
      stringz :name
      uint32le :created_year
      int64le :worth
      int64le :money
      int64le :income
      uint16le :performance
      uint8le :protected?
      string :vehicles, :length => 10 # trains, trucks, busses, plains, boats
      string :stations, :length => 10
      uint8le :is_ai

      #rest :foo

      boolean_encoding :protected?, :is_ai
    end

    class ServerAddress < OpenTTD::Encoding
      uint32le :ip
      uint16le :port

      def ip
        IPAddr.ntop(find_obj_for_name(:ip).to_binary_s)
      end
    end

    class Newgrf < OpenTTD::Encoding
      string :id, :length => 4
      string :md5sum, :length => 16 
    end
  end
end