# frozen_string_literal: true

KConfig.configure do |config|
  config.handlebars.helper(:ordinal, Handlebarsjs::Helpers::Inflection::Ordinal.new)
  config.handlebars.helper(:ordinalize, Handlebarsjs::Helpers::Inflection::Ordinalize.new)
  config.handlebars.helper(:pluralize, Handlebarsjs::Helpers::Inflection::Pluralize.new)
  config.handlebars.helper(:pluralize_number, Handlebarsjs::Helpers::Inflection::PluralizeNumber.new)
  config.handlebars.helper(:pluralize_number_word, Handlebarsjs::Helpers::Inflection::PluralizeNumberWord.new)
  config.handlebars.helper(:singularize, Handlebarsjs::Helpers::Inflection::Singularize.new)
end
