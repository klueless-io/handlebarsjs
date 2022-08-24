# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # String manipulation
    module Str
      # Padr: take the value and give it padding on the right hand side
      class Padr < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Str::Padr)

        def to_proc
          ->(value, count = nil, char = nil, _opts) { cmdlet.call(value, count, char) }
        end
      end
    end
  end
end
