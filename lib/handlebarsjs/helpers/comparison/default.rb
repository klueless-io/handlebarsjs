# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.
    module Comparison
      # Default: Return true if **all of** the given values are truthy.
      class Default < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Comparison::Default)

        def to_proc
          ->(*values, _opts) { wrapper(cmdlet.call(*values)) }
        end
      end
    end
  end
end
