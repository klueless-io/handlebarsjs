# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.
    module Comparison
      # Ne: Return true if left hand side is NOT equal to right hand side
      class Ne < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Comparison::Ne)

        def to_proc
          ->(lhs, rhs, _opts) { wrapper(cmdlet.call(lhs, rhs)) }
        end
      end
    end
  end
end
