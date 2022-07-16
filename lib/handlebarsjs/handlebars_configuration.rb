# frozen_string_literal: true

module Handlebarsjs
  # Configuration data such has helpers for handlebarsjs
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
