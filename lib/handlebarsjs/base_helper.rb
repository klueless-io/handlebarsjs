# frozen_string_literal: true

module Handlebarsjs
  # Extend base helper for each of your custom handlebars-helpers
  class BaseHelper
    # Wrap the parse method in a handlebars context aware block
    # and return as a lambda/proc so that it is available to the
    # Handlebars template engine
    def to_proc
      ->(value, _opts) { wrapper(parse(value)) }
    end

    # All child classes will generally implement this method
    def parse(value)
      value
    end

    # If you need to wrap the return value in a specific
    # Handlebars Type, eg. SafeString, then you can override this method
    def wrapper(value)
      value
    end
  end
end
