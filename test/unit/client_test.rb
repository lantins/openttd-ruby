require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

describe 'OpenTTD::Client' do
    before(:each) do
        @client = OpenTTD::Client.new
    end
    
    test '#query_server_details' do
        details = @client.query_server_details TEST_SERVER_ADDRESS, TEST_SERVER_PORT
        
        details.companies_max.should.equal 8
        details.dedicated?.should.equal true
    end
    
    test '#query_server_companies' do
        companies = @client.query_server_companies TEST_SERVER_ADDRESS, TEST_SERVER_PORT
        companies[0].id.should.equal 0
        companies[0].protected?.should.equal false
    end
end

#describe 'Using a subclass of OpenTTD::Client' do
#end