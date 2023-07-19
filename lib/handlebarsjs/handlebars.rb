# frozen_string_literal: true

module Handlebarsjs
  # API for interacting with Handlebars.js while providing native Ruby helpers
  class Handlebars < Handlebarsjs::Javascript
    def initialize
      super

      add_libraries
      add_configured_helpers
    end

    class << self
      def register_helper_script(name, parameter_names = [], safe: false, block: false)
        if safe && block
          block_helper_safe(name, parameter_names)
        elsif safe
          # register_safe_string_helper_script(name, parameter_names)
          function_helper_safe(name, parameter_names)
        elsif block
          block_helper(name, parameter_names)
        else
          function_helper(name)
        end
      end

      # In handlebars, this is a simple function expression
      def function_helper(name)
        # Not sure why I am not using paramater names, but currently it works for the existing use cases
        <<-JAVASCRIPT
          Handlebars.registerHelper('#{name}', ruby_#{name})
        JAVASCRIPT
      end

      # In handlebars, this is also a simple function expression that returns a SafeString when HTML is desired
      def function_helper_safe(name, parameter_names)
        parameters = (parameter_names + ['_opts']).join(', ')

        <<-JAVASCRIPT
          Handlebars.registerHelper('#{name}', function (#{parameters}) {
            return new Handlebars.SafeString(ruby_#{name}(#{parameters}));
          })
        JAVASCRIPT
      end

      def block_helper(name, parameter_names)
        parameters = (parameter_names + ['opts']).join(', ')
        ruby_parameters = parameters.length.positive? ? ", #{parameters}" : ''

        <<-JAVASCRIPT
          console.log('block_helper:1111:#{name}')
          Handlebars.registerHelper('#{name}', function (#{parameters}) {
            console.log('block_helper:2222:#{name}')
            return ruby_#{name}(opts.fn(this)#{ruby_parameters});
          })
        JAVASCRIPT
      end

      def block_helper_safe(name, parameter_names)
        parameters = (parameter_names + ['opts']).join(', ')
        ruby_parameters = parameters.length.positive? ? ", #{parameters}" : ''

        <<-JAVASCRIPT
          Handlebars.registerHelper('#{name}', function (#{parameters}) {
            return  new Handlebars.SafeString(ruby_#{name}(opts.fn(this)#{ruby_parameters}));
          })
        JAVASCRIPT
      end
    end

    def process_template(template, options = {})
      # TODO: process template function may be improved with some type of caching
      context.call('process_template', template, options)
    end

    private

    def add_libraries
      # Handlebars 4.7.7
      gem_path = Gem.loaded_specs['handlebarsjs'].full_gem_path

      handlebars_lib_path = File.join(gem_path, Handlebarsjs::HANDLEBARS_LIBRARY_PATH)
      handlebars_api_path = File.join(gem_path, Handlebarsjs::HANDLEBARS_API_PATH)
      handlebars_helpers_path = File.join(gem_path, Handlebarsjs::HANDLEBARS_HELPERS_PATH)

      handlebars_snapshot.add_library('handlebars', path: handlebars_lib_path)

      # Support my custom functions from handlebars-api
      handlebars_snapshot.add_library('handlebars-api', path: handlebars_api_path)

      # I have not been able to get block helpers working through ruby and so if I just need some custom JS only helpers, such as block then this is the place to do it
      handlebars_snapshot.add_library('handlebars-helper', path: handlebars_helpers_path)
    end

    def add_configured_helpers
      KConfig.configuration.handlebars.helpers.each do |helper_config|
        handlebars_snapshot.add_helper(helper_config.name, helper_config.helper)
      end
    end
  end
end
