require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

describe 'OpenTTD::Client' do
    before(:each) do
        @client = OpenTTD::Client.new
    end
    
    test '#game_info' do
        info = @client.game_info TEST_SERVER_ADDRESS, TEST_SERVER_PORT
    end
    
    test '#detail_info' do
        detail_info = @client.detail_info TEST_SERVER_ADDRESS, TEST_SERVER_PORT
    end
end

#describe 'Using a subclass of OpenTTD::Client' do
#end