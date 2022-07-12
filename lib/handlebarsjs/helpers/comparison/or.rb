# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.
    module Comparison
      # Or: Return true if any value is truthy.
      class Or < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Comparison::Or)

        def to_proc
          ->(*values, _opts) { wrapper(cmdlet.call(*values)) }
        end
      end
    end
  end
end
