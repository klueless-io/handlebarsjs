# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Inflection handling routines, eg. pluralize, singular, ordinalize
    module Inflection
      # Ordinal: The suffix that should be added to a number to denote the position in an ordered sequence such as 1st, 2nd, 3rd, 4th
      class Ordinal < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Inflection::Ordinal)

        def to_proc
          ->(value, _opts) { wrapper(cmdlet.call(value)) }
        end
      end
    end
  end
end
