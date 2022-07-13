# frozen_string_literal: true

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
