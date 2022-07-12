# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Inflection handling routines, eg. pluralize, singular, ordinalize
    module Inflection
      # PluralizeByNumber: Returns the plural form of the word based on a count
      class PluralizeByNumber < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Inflection::PluralizeByNumber)

        def to_proc
          ->(value, count, format, _opts) { wrapper(cmdlet.call(value, count, format)) }
        end
      end
    end
  end
end
