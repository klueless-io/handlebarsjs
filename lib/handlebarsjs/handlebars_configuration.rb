# frozen_string_literal: true

module Handlebarsjs
  # handlebars.handlebars_snapshot.add_helper(helper_name, helper)
  # Structure for storing Cmdlet configuration
  class HandlebarsConfiguration
    include KLog::Logging

    attr_accessor :helpers
    attr_reader :defaults

    def initialize
      @helpers = []
      @defaults = Handlebarsjs::HandlebarsConfigurationDefaults.new
    end

    HelperConfig = Struct.new(:name, :helper)

    def helper(name, helper, aliases: [])
      names = [name.to_sym]
      names = (names + aliases.map(&:to_sym)).uniq

      names.each do |helper_name|
        @helpers << HelperConfig.new(helper_name, helper)
      end
    end
  end
end
