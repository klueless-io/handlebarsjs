# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Tokenize and apply case and/or separator
    module Case
      # Camel: Camel case the characters in the given &#x27;string&#x27;
      class Camel < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Case::Camel)

        def to_proc
          ->(value, _opts) { wrapper(cmdlet.call(value)) }
        end
      end
    end
  end
end
