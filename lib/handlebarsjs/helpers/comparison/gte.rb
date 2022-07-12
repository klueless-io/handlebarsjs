# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.
    module Comparison
      # Gte: Return true if left hand side GREATER THAN or EQUAL TO right hand side
      class Gte < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Comparison::Gte)

        def to_proc
          ->(lhs, rhs, _opts) { wrapper(cmdlet.call(lhs, rhs)) }
        end
      end
    end
  end
end
