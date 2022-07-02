# frozen_string_literal: true

module Handlebarsjs
  # API for interacting with Javascript while providing native Ruby helpers
  class Javascript
    attr_reader :snapshot_builder

    def initialize
      @snapshot_builder = SnapshotBuilder.new
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
      @context ||= MiniRacer::Context.new(snapshot: snapshot_builder.build)
    end
  end
end
