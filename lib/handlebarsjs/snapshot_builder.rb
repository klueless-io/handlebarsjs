# frozen_string_literal: true

module Handlebarsjs
  # Wraps MiniRacer snapshot and provides clean API
  class SnapshotBuilder
    attr_reader :scripts

    def initialize
      @scripts = []
    end

    def add_handlebars_js
      add_script('handlebars', 'library', path: Handlebarsjs::JAVASCRIPT_PATH)
    end

    def add_library(name, script: nil, path: nil)
      add_script(name, 'library', script: script, path: path)
    end

    def register_helper(name)
      add_script(name, 'helper', script: "Handlebars.registerHelper('#{name}', ruby_#{name})")
    end

    def script
      scripts.map { |script| "# #{script[:type]} - #{script[:name]}\n#{script[:script]}" }.join("\n\n")
    end

    def build
      MiniRacer::Snapshot.new(script)
    end

    private

    def add_script(name, type, script: nil, path: nil)
      raise Handlebarsjs::Error, 'script or path is required' if script.nil? && path.nil?
      raise Handlebarsjs::Error, 'script and path are mutually exclusive' if script && path

      script ||= File.read(path)
      add_script_item(name, type, script, path)
    end

    def add_script_item(name, type, script, path = nil)
      scripts << {
        name: name,
        type: type,
        script: script,
        path: path
      }
    end
  end
end
