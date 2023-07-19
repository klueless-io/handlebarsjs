# frozen_string_literal: true

require 'mini_racer'
require 'cmdlet'
require_relative 'handlebarsjs/version'
require_relative 'handlebarsjs/javascript'
require_relative 'handlebarsjs/handlebars_snapshot'
require_relative 'handlebarsjs/handlebars'
require_relative 'handlebarsjs/base_helper'
require_relative 'handlebarsjs/handlebars_configuration_defaults'
require_relative 'handlebarsjs/handlebars_configuration'
require_relative 'handlebarsjs/handlebars_configuration_extension'
require_relative '_'

# Handlebarsjs is a Ruby wrapper for the Handlebars.js templating engine.
module Handlebarsjs
  HANDLEBARS_LIBRARY_PATH = 'lib/handlebarsjs/javascript/handlebars-4.7.7.js'
  HANDLEBARS_API_PATH = 'lib/handlebarsjs/javascript/handlebars-api.js'
  HANDLEBARS_HELPERS_PATH = 'lib/handlebarsjs/javascript/handlebars-helpers.js'

  # raise Handlebarsjs::Error, 'Sample message'
  Error = Class.new(StandardError)

  class << self
    # Get a singleton instance of the Handlebars engine.
    #
    # The engine is exposed as a singleton and that means that if you
    # alter the configuration after calling Handlebarsjs.engine,
    # you will have old helper state attached to the engine.
    #
    # If you need to update your helper state, then run Handlebarsjs.reset
    # to clear the singleton
    def engine
      @engine ||= Handlebarsjs::Handlebars.new
    end

    def reset
      @engine = nil
    end

    def render(template, options = {})
      engine.process_template(template, options)
    end
  end
end

if ENV.fetch('KLUE_DEBUG', 'false').downcase == 'true'
  namespace = 'Handlebarsjs::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('handlebarsjs/version') }
  version   = Handlebarsjs::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end
