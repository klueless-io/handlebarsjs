# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Tokenize and apply case and/or separator
    module Case
      # Slash: Slash case the characters in the given &#x27;string&#x27;
      class Slash < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Case::Slash)

        def to_proc
          ->(value, _opts) { wrapper(cmdlet.call(value)) }
        end
      end
    end
  end
end
