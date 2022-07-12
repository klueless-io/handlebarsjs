# frozen_string_literal: true

module Handlebarsjs
  # API for interacting with Handlebars.js while providing native Ruby helpers
  class Handlebars < Handlebarsjs::Javascript
    def initialize
      super
      # Handlebars 4.7.7
      gem_path = Gem.loaded_specs['handlebarsjs'].full_gem_path

      handlebars_lib_path = File.join(gem_path, Handlebarsjs::HANDLEBARS_LIBRARY_PATH)
      handlebars_api_path = File.join(gem_path, Handlebarsjs::HANDLEBARS_API_PATH)

      handlebars_snapshot.add_library('handlebars', path: handlebars_lib_path)

      # Support functions for working with
      handlebars_snapshot.add_library('handlebars-api', path: handlebars_api_path)
    end

    def process_template(template, options = {})
      # TODO: process template function may be improved with some type of caching
      context.call('process_template', template, options)
    end
  end
end
