# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Inflection handling routines, eg. pluralize, singular, ordinalize
    module Inflection
      # PluralizeNumberWord: Returns the plural form of the word based on a count with the count prefixed in the format &quot;3 categories&quot;
      class PluralizeNumberWord < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Inflection::PluralizeNumberWord)

        def to_proc
          ->(value, count, _opts) { wrapper(cmdlet.call(value, count)) }
        end
      end
    end
  end
end
