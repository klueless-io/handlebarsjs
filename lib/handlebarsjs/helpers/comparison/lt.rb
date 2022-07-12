# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.
    module Comparison
      # Lt: Return true if left hand side LESS THAN right hand side
      class Lt < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Comparison::Lt)

        def to_proc
          ->(lhs, rhs, _opts) { wrapper(cmdlet.call(lhs, rhs)) }
        end
      end
    end
  end
end
