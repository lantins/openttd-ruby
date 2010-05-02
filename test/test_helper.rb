dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + '/../lib'
$TESTING = true

require 'test/unit'
require 'rr'
require 'turn'

require 'openttd'

TEST_SERVER_ADDRESS = 'kyra.lon.lividpenguin.com'
TEST_SERVER_PORT = 3979

class Test::Unit::TestCase
  include RR::Adapters::TestUnit
end