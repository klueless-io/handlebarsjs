# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.
    module Comparison
      # Gt: Return true if left hand side GREATER THAN right hand side
      class Gt < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Comparison::Gt)

        def to_proc
          ->(lhs, rhs, _opts) { wrapper(cmdlet.call(lhs, rhs)) }
        end
      end
    end
  end
end
