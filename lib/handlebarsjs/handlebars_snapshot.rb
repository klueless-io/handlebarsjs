# frozen_string_literal: true

module Handlebarsjs
  # Wraps MiniRacer snapshot with specific emphasis on
  # loading Handlebars helpers onto the MiniRacer context
  # in the correct order. So that new contexts are preloaded
  # with the handlebars library and the configured helpers.
  class HandlebarsSnapshot
    attr_reader :scripts
    attr_reader :helpers

    def initialize
      @scripts = []
      @helpers = []
    end

    def add_library(name, script: nil, path: nil)
      add_script(name, 'library', script: script, path: path)
    end

    def add_snippet(name, script: nil, path: nil)
      add_script(name, 'snippet', script: script, path: path)
    end

    def add_helper(name, helper)
      return add_helper_entry(name, callback: helper) if helper.is_a?(Proc)
      return add_helper_entry(name, helper: helper, callback: helper.to_proc) if helper.respond_to?(:to_proc)

      raise Handlebarsjs::Error, 'helper must be a callback or implement to_proc method' if callback.nil?
    end

    def register_helper(name)
      add_script(name, 'helper', script: "Handlebars.registerHelper('#{name}', ruby_#{name})")
    end

    def script
      scripts.map { |script| "// #{script[:type]} - #{script[:name]}\n#{script[:script]}" }.join("\n\n")
    end

    def snapshot
      @snapshot ||= MiniRacer::Snapshot.new(script)
    end

    # rubocop:disable Style/DocumentDynamicEvalDefinition
    def new_context
      context = MiniRacer::Context.new(snapshot: snapshot)

      helpers.each do |helper|
        context.attach("ruby_#{helper[:name]}", helper[:callback])
        context.eval("Handlebars.registerHelper('#{helper[:name]}', ruby_#{helper[:name]})")
      end

      context
    end
    # rubocop:enable Style/DocumentDynamicEvalDefinition

    # not currently used
    def dirty?
      @snapshot.nil?
    end

    def debug
      puts script
    end

    private

    def add_script(name, type, script: nil, path: nil)
      raise Handlebarsjs::Error, 'script or path is required' if script.nil? && path.nil?
      raise Handlebarsjs::Error, 'script and path are mutually exclusive' if script && path

      script ||= File.read(path)
      add_script_item(name, type, script, path)
    end

    def add_helper_entry(name, helper: nil, callback: nil)
      @helpers << {
        name: name,
        helper: helper,
        callback: callback
      }
    end

    def add_script_item(name, type, script, path = nil)
      @snapshot = nil
      scripts << {
        name: name,
        type: type,
        script: script,
        path: path
      }
    end
  end
end
