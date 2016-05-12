require "bundler/gem_tasks"
require "rake/testtask"

task :default => :test

desc "Run test"
Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = (Dir["test/test_*.rb"] + Dir["test/plugin/test_*.rb"]).sort
  t.verbose = false
  t.warning = false
end
