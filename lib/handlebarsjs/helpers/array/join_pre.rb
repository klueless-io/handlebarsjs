# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # Array handling routines, eg. join, join_prefix, join_post
    module Array
      # JoinPre: join an array of values with separator as a string and using the separator at the beginning of string
      class JoinPre < Handlebarsjs::BaseHelper
        register_cmdlet(Cmdlet::Array::JoinPre)

        def to_proc
          ->(values, separator = ',', _opts) { wrapper(cmdlet.call(values, separator)) }
        end
      end
    end
  end
end
