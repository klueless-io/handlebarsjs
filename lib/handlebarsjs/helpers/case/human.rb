# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Tokenize and apply case and/or separator
    module Case
      # Human: Human case the characters in the given &#x27;string&#x27;
      class Human < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Case::Human)

        def to_proc
          ->(value, _opts) { wrapper(cmdlet.call(value)) }
        end
      end
    end
  end
end
