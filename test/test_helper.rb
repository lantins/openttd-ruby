rootdir = File.dirname(File.dirname(__FILE__))
$LOAD_PATH.unshift rootdir + '/test'
$LOAD_PATH.unshift rootdir + '/lib'

require 'test/unit'
require 'test/spec'
require 'rr'

begin
    require 'turn' # nicer test output.
rescue LoadError
end

require 'openttd'

# extend Test::Unit
class Test::Unit::TestCase
    include RR::Adapters::TestUnit
    
    def self.test(name, &block)
      test_name = "test_#{name.gsub(/\s+/,'_')}".to_sym
      defined = instance_method(test_name) rescue false
      raise "#{test_name} is already defined in #{self}" if defined
      if block_given?
        define_method(test_name, &block)
      else
        define_method(test_name) do
          flunk "No implementation provided for #{name}"
        end
      end
    end
end

alias :context :describe