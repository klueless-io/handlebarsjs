# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.
    module Comparison
      # Lte: Return true if left hand side LESS THAN or EQUAL TO right hand side
      class Lte < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Comparison::Lte)

        def to_proc
          ->(lhs, rhs, _opts) { wrapper(cmdlet.call(lhs, rhs)) }
        end
      end
    end
  end
end
