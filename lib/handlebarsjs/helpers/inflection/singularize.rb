# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Inflection handling routines, eg. pluralize, singular, ordinalize
    module Inflection
      # Singularize: The reverse of #pluralize, returns the singular form of a word in a string
      class Singularize < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Inflection::Singularize)

        def to_proc
          ->(value, _opts) { wrapper(cmdlet.call(value)) }
        end
      end
    end
  end
end
