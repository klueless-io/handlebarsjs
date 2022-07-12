# frozen_string_literal: true

module Handlebarsjs
  # Register this configuration access extension for Handlebars configuration
  module HandlebarsConfigurationExtension
    def handlebars
      return @handlebars if defined? @handlebars

      @handlebars = HandlebarsConfiguration.new
    end
  end

  # handlebars.handlebars_snapshot.add_helper(helper_name, helper)
  # Structure for storing Cmdlet configuration
  class HandlebarsConfiguration
    include KLog::Logging

    attr_accessor :helpers

    def initialize
      @helpers = []
    end

    HelperConfig = Struct.new(:name, :helper)

    def helper(name, helper)
      @helpers << HelperConfig.new(name, helper)
    end
  end
end

KConfig::Configuration.register(:handlebars, Handlebarsjs::HandlebarsConfigurationExtension)
