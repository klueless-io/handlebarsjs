# frozen_string_literal: true

module Handlebarsjs
  # API for interacting with Handlebars.js while providing native Ruby helpers
  class Handlebars < Handlebarsjs::Javascript
    def initialize
      super
      # Handlebars 4.7.7
      snapshot_builder.add_library('handlebars', path: Handlebarsjs::HANDLEBARS_LIBRARY_PATH)

      # Support functions for working with 
      snapshot_builder.add_library('handlebars-api', path: Handlebarsjs::HANDLEBARS_API_PATH)
    end

    def process_template(template, options = {})
      context.call('process_template', template, options)
    end
  end
end
