# frozen_string_literal: true

module Handlebarsjs
  # Pre-configure default helpers for each category
  class HandlebarsConfigurationDefaults
    def add_all_defaults
      add_array_defaults
      add_case_defaults
      add_comparison_defaults
      add_inflection_defaults
    end

    def add_array_defaults
      KConfig.configure do |config|
        config.handlebars.helper(:join, Handlebarsjs::Helpers::Array::Join.new)
        config.handlebars.helper(:join_post, Handlebarsjs::Helpers::Array::JoinPost.new)
        config.handlebars.helper(:join_pre, Handlebarsjs::Helpers::Array::JoinPre.new)
      end
    end

    def add_case_defaults
      KConfig.configure do |config|
        config.handlebars.helper(:back_slash, Handlebarsjs::Helpers::Case::BackSlash.new, aliases: %i[backward_slash slash_backward])
        config.handlebars.helper(:camel, Handlebarsjs::Helpers::Case::Camel.new, aliases: %i[camel_upper camelUpper camelU pascalcase])
        config.handlebars.helper(:constant, Handlebarsjs::Helpers::Case::Constant.new, aliases: %i[constantize])
        config.handlebars.helper(:dash, Handlebarsjs::Helpers::Case::Dash.new, aliases: %i[dasherize dashify dashcase hyphenate])
        config.handlebars.helper(:dot, Handlebarsjs::Helpers::Case::Dot.new, aliases: %i[dotirize dotify dotcase hyphenate])
        config.handlebars.helper(:double_colon, Handlebarsjs::Helpers::Case::DoubleColon.new)
        config.handlebars.helper(:human, Handlebarsjs::Helpers::Case::Human.new, aliases: %i[humanize sentence])
        config.handlebars.helper(:lamel, Handlebarsjs::Helpers::Case::Lamel.new, aliases: %i[camel_lower camelLower camelL])
        config.handlebars.helper(:lower, Handlebarsjs::Helpers::Case::Lower.new, aliases: %i[lowercase downcase])
        config.handlebars.helper(:slash, Handlebarsjs::Helpers::Case::Slash.new, aliases: %i[forward_slash slash_forward])
        config.handlebars.helper(:snake, Handlebarsjs::Helpers::Case::Snake.new)
        config.handlebars.helper(:title, Handlebarsjs::Helpers::Case::Title.new)
        config.handlebars.helper(:upper, Handlebarsjs::Helpers::Case::Upper.new, aliases: %i[upcase uppercase])
      end
    end

    def add_comparison_defaults
      KConfig.configure do |config|
        config.handlebars.helper(:and, Handlebarsjs::Helpers::Comparison::And.new)
        config.handlebars.helper(:default, Handlebarsjs::Helpers::Comparison::Default.new)
        config.handlebars.helper(:eq, Handlebarsjs::Helpers::Comparison::Eq.new)
        config.handlebars.helper(:gt, Handlebarsjs::Helpers::Comparison::Gt.new)
        config.handlebars.helper(:gte, Handlebarsjs::Helpers::Comparison::Gte.new)
        config.handlebars.helper(:lt, Handlebarsjs::Helpers::Comparison::Lt.new)
        config.handlebars.helper(:lte, Handlebarsjs::Helpers::Comparison::Lte.new)
        config.handlebars.helper(:ne, Handlebarsjs::Helpers::Comparison::Ne.new)
        config.handlebars.helper(:or, Handlebarsjs::Helpers::Comparison::Or.new)
      end
    end

    def add_inflection_defaults
      KConfig.configure do |config|
        config.handlebars.helper(:ordinal, Handlebarsjs::Helpers::Inflection::Ordinal.new)
        config.handlebars.helper(:ordinalize, Handlebarsjs::Helpers::Inflection::Ordinalize.new)
        config.handlebars.helper(:pluralize, Handlebarsjs::Helpers::Inflection::Pluralize.new)
        config.handlebars.helper(:pluralize_number, Handlebarsjs::Helpers::Inflection::PluralizeNumber.new)
        config.handlebars.helper(:pluralize_number_word, Handlebarsjs::Helpers::Inflection::PluralizeNumberWord.new)
        config.handlebars.helper(:singularize, Handlebarsjs::Helpers::Inflection::Singularize.new)
      end
    end
  end
end
