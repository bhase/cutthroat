require "bundler/gem_tasks"
require "cucumber/rake/task"

Cucumber::Rake::Task.new

task :default => :alltests

desc "run all tests (cucumber, Test::Unit)"
task :alltests => [:unit, :cucumber]

desc "run unit tests (Test::Unit)"
task :unit do
  ruby "test/run_test.rb"
end
