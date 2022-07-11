# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.
    module Comparison
      # And: Block helper that renders a block if **all of** the given values are truthy. If an inverse block is specified it will be rendered when falsy.
      class And < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Comparison::And)

        def to_proc
          ->(*values, _opts) { wrapper(cmdlet.call(*values)) }
        end
      end
    end
  end
end
