# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Inflection handling routines, eg. pluralize, singular, ordinalize
    module Inflection
      # PluralizeNumber: Returns the plural form of the word based on a count in the format &quot;categories&quot;
      class PluralizeNumber < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Inflection::PluralizeNumber)

        def to_proc
          ->(value, count, _opts) { wrapper(cmdlet.call(value, count)) }
        end
      end
    end
  end
end
