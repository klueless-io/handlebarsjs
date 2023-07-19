# frozen_string_literal: true

module Handlebarsjs
  # Extend base helper for each of your custom handlebars-helpers
  class BaseHelper
    attr_reader :cmdlet
    attr_reader :block
    attr_reader :safe
    attr_reader :parameter_names

    # Preferred way to register the internal command is via register_cmdlet
    # but you can also register the command directly in the initializer and
    # that can be handy if you use a custom configured cmdlet
    def initialize(cmdlet = nil, safe: nil, parameter_names: nil)
      initialize_cmdlet(cmdlet)
      initialize_safe(safe)
      initialize_block(block)
      initialize_parameter_names(parameter_names)
    end

    class << self
      attr_reader :cmdlet
      attr_reader :block
      attr_reader :safe
      attr_reader :parameter_names

      # Register the cmdlet to be used by the helper
      #
      # By default, it will register an function expression helper
      # You can use HTML by setting safe to true
      #
      # @param cmdlet [Handlebarsjs::Cmdlet::Base] the cmdlet to be used by the helper
      # @param block [Boolean] whether or not this is a wrapped block
      # @param safe [Boolean] whether or not the cmdlet should return HTML
      # @param parameter_names [Array] the parameter names to be used by the cmdlet
      def register_cmdlet(cmdlet, block: false, safe: false, parameter_names: [])
        @cmdlet = cmdlet
        @block = block
        @safe = safe
        @parameter_names = parameter_names
      end
    end

    # If you need to wrap the return value then you can override this method
    def wrapper(value)
      value
    end

    # Wrap the cmdlet call method in a handlebars context aware block
    # and return as a lambda/proc so that it is available to the
    # Handlebars template engine
    def to_proc
      ->(value, _opts) { wrapper(cmdlet.call(value)) }
    end

    private

    def initialize_cmdlet(cmdlet)
      @cmdlet = cmdlet
      @cmdlet = self.class.cmdlet.new if @cmdlet.nil? && self.class.cmdlet
    end

    def initialize_safe(safe)
      @safe = safe
      @safe = self.class.safe if @safe.nil? && self.class.safe
      @safe = false if @safe.nil?
    end

    def initialize_block(block)
      @block = block
      @block = self.class.block if @block.nil? && self.class.block
      @block = false if @block.nil?
    end

    def initialize_parameter_names(parameter_names)
      @parameter_names = parameter_names
      @parameter_names = self.class.parameter_names if parameter_names.nil? && self.class.parameter_names
      @parameter_names = [] if @parameter_names.nil?
    end
  end
end
