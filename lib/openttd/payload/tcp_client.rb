module OpenTTD
    module Payload
        class TcpClientAck < OpenTTD::Encoding
            uint32le :frame
        end
        
        class TcpClientChat < OpenTTD::Encoding
            uint8    :action_id
            uint8    :type_id
            uint32le :client_id
            stringz  :message
            uint64le :data
            
            lookup_encoding :action_id, :type_id
            
            def encodeing_lookup_map
                CHAT_ENCODING_MAP
            end
        end
        
        class TcpClientCommand < OpenTTD::Encoding
            uint8   :company
            uint32le :command_id
            uint32le :p1
            uint32le :p2
            uint32le :tile
            stringz :text
            uint8 :callback_id
        end
        
        class TcpClientError < OpenTTD::Encoding
            uint8 :error_code
        end
        
        class TcpClientGetmap < OpenTTD::Encoding
            uint32le    :version
        end
        
        class TcpClientJoin < OpenTTD::Encoding
            stringz :client_version
            stringz :player_name
            uint8   :company
            uint8   :language
            stringz :network_id
        end
        
        class TcpClientMove < OpenTTD::Encoding
            uint8 :company
            stringz :password_hash
        end
        
        class TcpClientPassword < OpenTTD::Encoding
            uint8 :password_type
            stringz :password
        end
        
        class TcpClientRcon < OpenTTD::Encoding
            stringz :password
            stringz :command
        end
        
        class TcpClientSetName < OpenTTD::Encoding
            stringz :name
        end
        
        class TcpClientSetPassword < OpenTTD::Encoding
            stringz :password_hash
            
            #  for (uint i = 0; i < NETWORK_SERVER_ID_LENGTH - 1; i++) 
            #  salted_password[i] ^= _password_server_id[i] ^ (_password_game_seed >> i);
            #  checksum.Append((const uint8*)salted_password, sizeof(salted_password) - 1);
            #  checksum.Finish(digest);
            #  for (int di = 0; di < 16; di++) sprintf(hashed_password + di * 2, "%02x", digest[di]);
            #  hashed_password[lengthof(hashed_password) - 1] = '\0';
            
        end
    end
end