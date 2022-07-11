# frozen_string_literal: true

module Handlebarsjs
  # Extend base helper for each of your custom handlebars-helpers
  class BaseHelper
    attr_reader :cmdlet

    # Preferred way to register the internal command is via register_cmdlet
    # but you can also register the command directly in the initializer and
    # that can be handy if you use a custom configured cmdlet
    def initialize(cmdlet = nil)
      @cmdlet = cmdlet
      @cmdlet = self.class.cmdlet.new if @cmdlet.nil? && self.class.cmdlet
    end

    class << self
      attr_reader :cmdlet

      def register_cmdlet(cmdlet)
        @cmdlet = cmdlet
      end
    end

    # If you need to wrap the return value in a specific
    # Handlebars Type, eg. SafeString, then you can override this method
    def wrapper(value)
      value
    end

    # Wrap the cmdlet call method in a handlebars context aware block
    # and return as a lambda/proc so that it is available to the
    # Handlebars template engine
    def to_proc
      ->(value, _opts) { wrapper(cmdlet.call(value)) }
    end
  end
end
