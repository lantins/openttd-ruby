module OpenTTD
    module Payload
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