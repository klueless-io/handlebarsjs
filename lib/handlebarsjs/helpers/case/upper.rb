# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Tokenize and apply case and/or separator
    module Case
      # Upper: Upper case the characters in the given &#x27;string&#x27;
      class Upper < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Case::Upper)

        def to_proc
          ->(value, _opts) { wrapper(cmdlet.call(value)) }
        end
      end
    end
  end
end
