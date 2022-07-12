# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Tokenize and apply case and/or separator
    module Case
      # Constant: Constant case the characters in the given &#x27;string&#x27;
      class Constant < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Case::Constant)

        def to_proc
          ->(value, _opts) { wrapper(cmdlet.call(value)) }
        end
      end
    end
  end
end
