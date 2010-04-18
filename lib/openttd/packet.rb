module OpenTTD
    module Packet
        MIN_LENGTH = 3 # min length of a packet in bytes.
        
        UDP_PAYLOAD_OPCODES = {
            0 => :udp_client_find_server,   # Queries a game server for game information
            1 => :udp_server_response,      # Reply of the game server with game information
            2 => :udp_client_detail_info,   # Queries a game server about details of the game, such as companies
            3 => :udp_server_detail_info,   # Reply of the game server about details of the game, such as companies
            #4 => :udp_server_register,      # Packet to register itself to the master server
            #5 => :udp_master_ack_register,  # Packet indicating registration has succedeed
            6 => :udp_client_get_list,      # Request for serverlist from master server
            7 => :udp_master_response_list, # Response from master server with server ip's + port's
            #8 => :udp_server_unregister,    # Request to be removed from the server-list
            9 => :udp_client_get_newgrfs,   # Requests the name for a list of GRFs (GRF_ID and MD5)
            #0 => :udp_server_newgrfs,       # Sends the list of NewGRF's requested.
            #11 => :udp_master_session_key,   # Sends a fresh session key to the client
            #12 => :udp_end                   # Must ALWAYS be on the end of this list!! (period)
        }
        
        TCP_PAYLOAD_OPCODES = {
            0 => :tcp_server_full,
            1 => :tcp_server_banned,
            2 => :tcp_client_join,
            3 => :tcp_server_error,
            4 => :tcp_client_company_info,
            5 => :tcp_server_company_info,
            6 => :tcp_server_client_info,
            7 => :tcp_server_need_password,
            8 => :tcp_client_password,
            9 => :tcp_server_welcome,
            10 => :tcp_client_getmap,
            11 => :tcp_server_wait,
            12 => :tcp_server_map,
            13 => :tcp_client_map_ok,
            14 => :tcp_server_join,
            15 => :tcp_server_frame,
            16 => :tcp_server_sync,
            17 => :tcp_client_ack,
            18 => :tcp_client_command,
            19 => :tcp_server_command,
            20 => :tcp_client_chat,
            21 => :tcp_server_chat,
            22 => :tcp_client_set_password,
            23 => :tcp_client_set_name,
            24 => :tcp_client_quit,
            25 => :tcp_client_error,
            26 => :tcp_server_quit,
            27 => :tcp_server_error_quit,
            28 => :tcp_server_shutdown,
            29 => :tcp_server_newgame,
            30 => :tcp_server_rcon,
            31 => :tcp_client_rcon,
            32 => :tcp_server_check_newgrfs,
            33 => :tcp_client_newgrfs_checked,
            34 => :tcp_server_move,
            35 => :tcp_client_move,
            36 => :tcp_server_company_update,
            37 => :tcp_server_config_update,
            #38 => :tcp_end
        }
        
        def self.extract_packets!(buffer)
            packets = []
            
            while buffer.length >= OpenTTD::Packet::MIN_LENGTH
                length = buffer[0, 2].unpack('S').first
                break unless buffer.length >= length
                
                packets << buffer.slice!(0..length - 1)
            end
            packets
        end
        
        class Container < OpenTTD::Encoding
            uint16le :total_length, :value => lambda { self.num_bytes }
            uint8 :opcode, :initial_value => 0
            
            lookup_encoding :opcode
            
            def self.build(opcode, &block)
                packet = new
                packet.opcode = opcode
                block.call(packet.payload) if block_given?
                packet
            end
            
            def opcode_int
                obj = find_obj_for_name(:opcode)
            end
        end
        
        class UDP < OpenTTD::Packet::Container
            choice :payload, :choices => UDP_PAYLOAD_OPCODES, :selection => lambda { opcode_int }
            
            def encodeing_lookup_map
                { :opcode => UDP_PAYLOAD_OPCODES }
            end
        end
        
        class TCP < OpenTTD::Packet::Container
            choice :payload, :choices => TCP_PAYLOAD_OPCODES, :selection => lambda { opcode_int }
            
            def encodeing_lookup_map
                { :opcode => TCP_PAYLOAD_OPCODES }
            end
        end
    end
end