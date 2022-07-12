# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Tokenize and apply case and/or separator
    module Case
      # Title: Title case the characters in the given &#x27;string&#x27;
      class Title < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Case::Title)

        def to_proc
          ->(value, _opts) { wrapper(cmdlet.call(value)) }
        end
      end
    end
  end
end
