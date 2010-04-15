module OpenTTD
    class Client
        def initialize(&b)
            
        end
        
        def start
            
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