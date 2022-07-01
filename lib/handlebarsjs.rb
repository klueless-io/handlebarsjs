# frozen_string_literal: true

require 'mini_racer'
require_relative 'handlebarsjs/version'
require_relative 'handlebarsjs/snapshot_builder'
require_relative 'handlebarsjs/handlebars'

module Handlebarsjs
  JAVASCRIPT_PATH = 'lib/handlebarsjs/javascript/handlebars-4.7.7.js'

  # raise Handlebarsjs::Error, 'Sample message'
  Error = Class.new(StandardError)

  # Your code goes here...
end

if ENV.fetch('KLUE_DEBUG', 'false').downcase == 'true'
  namespace = 'Handlebarsjs::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('handlebarsjs/version') }
  version   = Handlebarsjs::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end
