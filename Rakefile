# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task(:default).clear
task default: ['test', :rubocop]

task :rubocop do
  require 'rubocop'
  cli = RuboCop::CLI.new
  cli.run(%w(-D --auto-correct --rails))
end
