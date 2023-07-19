# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Miscellaneous cmdlets
    module Misc
      # Omit: this content will not get written out, useful for commenting out code
      class Omit < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Misc::Omit)

        def to_proc
          ->(value, _opts) { wrapper(cmdlet.call(value)) }
        end
      end
    end
  end
end
