module OpenTTD
    module Packet
        MIN_LENGTH = 3 # min length of a packet in bytes.
        
        UDP_PAYLOAD_OPCODES = {
            0x00 => :udp_client_find_server,   # Queries a game server for game information
            0x01 => :udp_server_response,      # Reply of the game server with game information
            #0x02 => :udp_client_detail_info,   # Queries a game server about details of the game, such as companies
            #0x03 => :udp_server_detail_info,   # Reply of the game server about details of the game, such as companies
            #0x04 => :udp_server_register,      # Packet to register itself to the master server
            #0x05 => :udp_master_ack_register,  # Packet indicating registration has succedeed
            #0x06 => :udp_client_get_list,      # Request for serverlist from master server
            #0x07 => :udp_master_response_list, # Response from master server with server ip's + port's
            #0x08 => :udp_server_unregister,    # Request to be removed from the server-list
            #0x09 => :udp_client_get_newgrfs,   # Requests the name for a list of GRFs (GRF_ID and MD5)
            #0x10 => :udp_server_newgrfs,       # Sends the list of NewGRF's requested.
            #0x11 => :udp_master_session_key,   # Sends a fresh session key to the client
            #0x12 => :udp_end                   # Must ALWAYS be on the end of this list!! (period)
        }
        
        TCP_PAYLOAD_OPCODES = {
            0x00 => :tcp_server_full,
            #0x01 => :tcp_server_banned,
            #0x02 => :tcp_client_join,
            #0x03 => :tcp_server_error,
            0x04 => :tcp_client_company_info,
            0x05 => :tcp_server_company_info,
            #0x06 => :tcp_server_client_info,
            #0x07 => :tcp_server_need_game_password,
            #0x08 => :tcp_server_need_company_password,
            #0x09 => :tcp_client_game_password,
            #0x10 => :tcp_client_company_password,
            #0x11 => :tcp_server_welcome,
            #0x12 => :tcp_client_getmap,
            #0x13 => :tcp_server_wait,
            #0x14 => :tcp_server_map,
            #0x15 => :tcp_client_map_ok,
            #0x16 => :tcp_server_join,
            #0x17 => :tcp_server_frame,
            #0x18 => :tcp_server_sync,
            #0x19 => :tcp_client_ack,
            #0x20 => :tcp_client_command,
            #0x21 => :tcp_server_command,
            #0x22 => :tcp_client_chat,
            #0x23 => :tcp_server_chat,
            #0x24 => :tcp_client_set_password,
            #0x25 => :tcp_client_set_name,
            #0x26 => :tcp_client_quit,
            #0x27 => :tcp_client_error,
            #0x28 => :tcp_server_quit,
            #0x29 => :tcp_server_error_quit,
            #0x30 => :tcp_server_shutdown,
            #0x31 => :tcp_server_newgame,
            #0x32 => :tcp_server_rcon,
            #0x33 => :tcp_client_rcon,
            #0x34 => :tcp_server_check_newgrfs,
            #0x35 => :tcp_client_newgrfs_checked,
            #0x36 => :tcp_server_move,
            #0x37 => :tcp_client_move,
            #0x38 => :tcp_server_company_update,
            #0x39 => :tcp_server_config_update,
            #0x40 => :tcp_end
        }
        
        class Container < OpenTTD::Encoding
            uint16le :total_length, :value => lambda { self.num_bytes }
            uint8 :opcode, :initial_value => 0x00
            
            lookup_encoding :opcode
            
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