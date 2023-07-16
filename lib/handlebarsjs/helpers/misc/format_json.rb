# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Miscellaneous cmdlets
    module Misc
      # FormatJson: FormatJson will take an object and write it out as pretty JSON
      class FormatJson < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Misc::FormatJson)

        def to_proc
          ->(value, _opts) { wrapper(cmdlet.call(value)) }
        end
      end
    end
  end
end
