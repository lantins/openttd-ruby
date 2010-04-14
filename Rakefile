require 'rake/testtask'
require 'fileutils'

#
# Default Task
#
task :default => [:'test:unit']

#
# Tests
#
namespace 'test' do
    %w[unit integration].each do |target|
        Rake::TestTask.new(target) do |t|
          t.test_files = FileList["test/#{target}/**/*_test.rb"]
          t.verbose = true
        end
    end
end