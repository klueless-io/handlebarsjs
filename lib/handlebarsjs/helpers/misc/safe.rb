# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Miscellaneous cmdlets
    module Misc
      # Safe: pass through the value with &lt;&gt; and single and double quotes left as is
      class Safe < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Misc::Safe, safe: true, parameter_names: [:value])

        def to_proc
          ->(value, _opts) { wrapper(cmdlet.call(value)) }
        end
      end
    end
  end
end
