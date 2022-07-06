# frozen_string_literal: true

require 'mini_racer'
require_relative 'handlebarsjs/version'
require_relative 'handlebarsjs/javascript'
require_relative 'handlebarsjs/handlebars_snapshot'
require_relative 'handlebarsjs/handlebars'

module Handlebarsjs
  HANDLEBARS_LIBRARY_PATH = 'lib/handlebarsjs/javascript/handlebars-4.7.7.js'
  HANDLEBARS_API_PATH = 'lib/handlebarsjs/javascript/handlebars-api.js'

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
