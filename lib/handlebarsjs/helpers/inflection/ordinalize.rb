# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Inflection handling routines, eg. pluralize, singular, ordinalize
    module Inflection
      # Ordinalize: Turns a number into an ordinal string used to denote the position in an ordered sequence such as 1st, 2nd, 3rd, 4th.
      class Ordinalize < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Inflection::Ordinalize)

        def to_proc
          ->(value, _opts) { wrapper(cmdlet.call(value)) }
        end
      end
    end
  end
end
