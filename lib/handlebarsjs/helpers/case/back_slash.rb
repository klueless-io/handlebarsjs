# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Tokenize and apply case and/or separator
    module Case
      # BackSlash: Convert to back slash notation
      class BackSlash < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Case::BackSlash)

        def to_proc
          ->(value, _opts) { wrapper(cmdlet.call(value)) }
        end
      end
    end
  end
end
