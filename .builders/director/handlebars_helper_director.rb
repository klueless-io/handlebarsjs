# frozen_string_literal: true

class HandlebarsHelperDirector < KDirector::Directors::BaseDirector
  default_builder_type(HandlebarsHelperBuilder)

  def helper(**opts, &block)
    helper = HandlebarsHelperChild.new(self, **opts)
    helper.instance_eval(&block) if block_given?

    self
  end

  def build_helpers
    builder.helpers.each do |helper|
      cd(:lib)
      add("helpers/#{helper[:category]}/#{helper[:name]}.rb", template_file: 'helper.rb', helper: helper)

      cd(:spec)
      add("helpers/#{helper[:category]}/#{helper[:name]}_spec.rb", template_file: 'helper_spec.rb', helper: helper)
    end

    self
  end
end
