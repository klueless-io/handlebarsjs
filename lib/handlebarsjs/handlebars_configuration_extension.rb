# frozen_string_literal: true

module Handlebarsjs
  # Register this configuration access extension for Handlebars configuration
  module HandlebarsConfigurationExtension
    def handlebars
      return @handlebars if defined? @handlebars

      @handlebars = HandlebarsConfiguration.new
    end
  end
end

KConfig::Configuration.register(:handlebars, Handlebarsjs::HandlebarsConfigurationExtension)
