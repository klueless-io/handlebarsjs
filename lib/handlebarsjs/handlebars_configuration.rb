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

    def helper(name, helper)
      @helpers << HelperConfig.new(name, helper)
    end
  end
end
