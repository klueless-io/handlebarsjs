# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'rake'
  gem 'rake-compiler', require: false
  gem 'rspec', '~> 3.0'
  gem 'rubocop'
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
  gem 'simplecov', require: false

  # If local dependency
  if ENV['KLUE_LOCAL_GEMS']&.to_s&.downcase == 'true'
    puts 'Using Local GEMs'
    gem 'cmdlet' , path: '../cmdlet'
  end
end
