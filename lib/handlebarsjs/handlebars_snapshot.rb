# frozen_string_literal: true

module Handlebarsjs
  # Wraps MiniRacer snapshot with specific emphasis on
  # loading Handlebars helpers onto the MiniRacer context
  # in the correct order. So that new contexts are preloaded
  # with the handlebars library and the configured helpers.
  class HandlebarsSnapshot
    include KLog::Logging

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
      add_helper_entry(
        name: name,
        helper: helper,
        callback: helper.to_proc,
        safe: helper.safe,
        parameters: helper.parameter_names
      )
    end

    def add_callback(name, callback, safe, parameters)
      add_helper_entry(
        name: name,
        helper: nil,
        callback: callback,
        safe: safe,
        parameters: parameters
      )
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

    def new_context
      context = MiniRacer::Context.new(snapshot: snapshot)

      helpers.each do |helper_entry|
        attach_ruby(context, helper_entry)
        eval_register_helper(context, helper_entry)
      end

      context
    end

    # not currently used
    def dirty?
      @snapshot.nil?
    end

    def debug
      data = { scripts: scripts, helpers: helpers }
      log.structure(data)
    end

    def debug_register_scripts
      register_scripts = helpers.map do |helper|
        # Handlebarsjs::Handlebars.register_safe_string_helper_script(
        #   helper[:name]
        # )
        # helper[:helper].build_register_helper_script(
        #   helper[:name],
        #   safe: helper[:safe]
        # )
      end
      puts register_scripts.join("\n")
    end

    private

    def add_script(name, type, script: nil, path: nil)
      raise Handlebarsjs::Error, 'script or path is required' if script.nil? && path.nil?
      raise Handlebarsjs::Error, 'script and path are mutually exclusive' if script && path

      script ||= File.read(path)
      add_script_item(name, type, script, path)
    end

    def add_helper_entry(**args)
      entry = {
        name: args[:name],
        helper: args[:helper],
        callback: args[:callback],
        safe: args[:safe],
        parameters: args[:parameters]
      }

      @helpers << entry

      entry
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

    # This context should be on handlebars, not snapshot (I THINK)
    def attach_ruby(context, helper_entry)
      name = helper_entry[:name]
      callback = helper_entry[:callback]

      context.attach("ruby_#{name}", callback)
    end

    def eval_register_helper(context, helper_entry)
      script = build_register_helper_script(helper_entry)

      context.eval(script)
    end

    def build_register_helper_script(helper_entry)
      # When registering a helper, set the safe flag to true when you want a HTML Safe String
      # register_cmdlet(Cmdlet::SomeHtmlCommand, safe: true, parameter_names: %i[value])
      name = helper_entry[:name]
      safe = helper_entry[:safe] || false
      block = helper_entry[:block] || false
      parameter_names = helper_entry[:parameters] || []

      Handlebarsjs::Handlebars.register_helper_script(name, parameter_names, safe: safe, block: block)

      #   return Handlebarsjs::Handlebars.register_safe_string_helper_script(helper_entry[:name], helper_entry[:parameters]) if helper_entry[:safe]

      #   Handlebarsjs::Handlebars.register_helper_script(helper_entry[:name])
    end
  end
end
