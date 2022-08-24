# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # String manipulation
    module Str
      # Padl: take the value and give it padding on the left hand side
      class Padl < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Str::Padl)

        def to_proc
          ->(value, count = nil, char = nil, _opts) { wrapper(cmdlet.call(value, count, char)) }
        end
      end
    end
  end
end
