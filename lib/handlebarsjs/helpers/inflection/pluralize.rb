# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Inflection handling routines, eg. pluralize, singular, ordinalize
    module Inflection
      # Pluralize: Returns the plural form of the word in the string
      class Pluralize < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Inflection::Pluralize)

        def to_proc
          ->(value, _opts) { wrapper(cmdlet.call(value)) }
        end
      end
    end
  end
end
