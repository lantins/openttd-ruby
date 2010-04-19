require 'rake/testtask'
require 'fileutils'
require 'yard'
require 'yard/rake/yardoc_task'

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

#
# Docs
#
YARD::Rake::YardocTask.new :yardoc do |t|
    t.files   = ['lib/**/*.rb']
    t.options = ['--output-dir', "doc/api",
                 '--files', 'LICENSE',
                 '--readme', 'README.markdown',
                 '--title', 'OpenTTD-Ruby - API Documentation']
end