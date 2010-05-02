require File.dirname(__FILE__) + '/test_helper'

class TestClient < Test::Unit::TestCase
  def setup
    @client = OpenTTD::Client.new
  end

  def test_query_server_details
    details = @client.query_server_details TEST_SERVER_ADDRESS, TEST_SERVER_PORT

    assert_equal 8, details.companies_max
    assert_equal true, details.dedicated?
  end

  def test_query_server_companies
    companies = @client.query_server_companies TEST_SERVER_ADDRESS, TEST_SERVER_PORT
    company_0 = companies[0]
    
    assert_equal 0, companies[0].id
    assert_equal false, companies[0].protected?
  end
end