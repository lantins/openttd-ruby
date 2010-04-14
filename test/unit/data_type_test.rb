require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

describe 'OpenTTD::DataType::CompanyInfo' do
    test 'decode binary data' do
        binary = "\x00Paws Logistics\x00\x9E\a\x00\x00\xBE2\x95\x16\x00\x00\x00\x00\xFA83\x16\x00\x00\x00\x00Gw\xB0\x01\x00\x00\x00\x00\x87\x03\x00\x93\x00\x00\x00\x00\x00\x00\x00\x00\x00'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        company_info = OpenTTD::DataType::CompanyInfo.new
        company_info.read(binary)
        
        #assert_equal(company_info.to_binary_s, binary)
        company_info.to_binary_s.should.equal binary
    end
end