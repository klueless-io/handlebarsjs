# frozen_string_literal: true

# source: https://stephenagrice.medium.com/making-a-command-line-ruby-gem-write-build-and-push-aec24c6c49eb

GEM_NAME = 'handlebarsjs'

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'handlebarsjs/version'

RSpec::Core::RakeTask.new(:spec)

require 'rake/extensiontask'

desc 'Compile all the extensions'
task build: :compile

Rake::ExtensionTask.new('handlebarsjs') do |ext|
  ext.lib_dir = 'lib/handlebarsjs'
end

desc 'Publish the gem to RubyGems.org'
task :publish do
  version = Handlebarsjs::VERSION
  system 'gem build'
  system "gem push #{GEM_NAME}-#{version}.gem"
end

desc 'Remove old *.gem files'
task :clean do
  system 'rm *.gem'
end

task default: %i[clobber compile spec]
