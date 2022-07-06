# frozen_string_literal: true

module Handlebarsjs
  # API for interacting with Javascript while providing native Ruby helpers
  class Javascript
    attr_reader :handlebars_snapshot

    def initialize
      @handlebars_snapshot = HandlebarsSnapshot.new
    end

    def eval(script)
      context.eval(script)
    end

    def attach(script, block)
      context.attach(script, block)
    end

    def call(function_name, *arguments)
      context.call(function_name, *arguments)
    end

    private

    def context
      puts 'Snapshot and context are out of date, calls to snapshot should happen before any calls to context' if !@context.nil? && handlebars_snapshot.dirty?
      @context ||= handlebars_snapshot.new_context
    end
  end
end
