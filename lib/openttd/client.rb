module OpenTTD
    class Client
        def initialize(&b)
            
        end
        
        # starts a TCP connection.
        def start
            
        end
        
        # sends 'udp_client_find_server' packet to get server details/settings.
        def query_server_details(server, port = 3979)
            
        end
        
        # sends 'udp_client_detail_info' to get company information.
        def query_server_companies(server, port = 3979)
        end
    end
    
    class TCPClient < EventMachine::Connection
        
    end
    
    class UDPConnection
        def start
            @signature = EventMachine.start_server('0.0.0.0', 3000, UDPClient) do |con|
              con.server = self
            end
        end
        
        def stop
            EventMachine.stop_server(@signature)
        end
    end
    
    class UDPClient < EventMachine::Connection
        
    end
end