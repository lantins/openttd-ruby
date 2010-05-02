require 'rake/testtask'
require 'fileutils'
require 'yard'
require 'yard/rake/yardoc_task'

task :default => :test

desc 'Run unit tests.'
Rake::TestTask.new(:test) do |task|
  task.test_files = FileList['test/**/*_test.rb']
  task.verbose = true
end

desc 'Build documentation.'
YARD::Rake::YardocTask.new :yardoc do |t|
  t.files   = ['lib/**/*.rb']
  t.options = ['--output-dir', "doc/",
               '--files', 'LICENSE',
               '--readme', 'README.md',
               '--title', 'OpenTTD Ruby - API Documentation']
end