module OpenTTD
    module Packet
        MIN_LENGTH = 3 # min length of a packet in bytes.
        
        PAYLOAD_OPCODES = {
            0x00 => :udp_game_info,
            0x01 => :udp_server_game_info,
            0x04 => :client_company_info,
            0x05 => :server_company_info
        }
        
        class Container < OpenTTD::Encoding
            uint16le :total_length, :value => lambda { self.num_bytes }
            uint8 :opcode, :initial_value => 0x00
            
            choice :payload, :choices => PAYLOAD_OPCODES,
                             :selection => lambda { opcode_int }
            
            lookup_encoding :opcode
            
            
            def opcode_int
                obj = find_obj_for_name(:opcode)
            end
            
            def encodeing_lookup_map
                {
                    :opcode => PAYLOAD_OPCODES
                }
            end
        end
    end
end