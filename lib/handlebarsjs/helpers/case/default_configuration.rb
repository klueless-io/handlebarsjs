# frozen_string_literal: true

KConfig.configure do |config|
  config.handlebars.helper(:back_slash, Handlebarsjs::Helpers::Case::BackSlash.new)
  config.handlebars.helper(:camel, Handlebarsjs::Helpers::Case::Camel.new)
  config.handlebars.helper(:constant, Handlebarsjs::Helpers::Case::Constant.new)
  config.handlebars.helper(:dash, Handlebarsjs::Helpers::Case::Dash.new)
  config.handlebars.helper(:dot, Handlebarsjs::Helpers::Case::Dot.new)
  config.handlebars.helper(:double_colon, Handlebarsjs::Helpers::Case::DoubleColon.new)
  config.handlebars.helper(:human, Handlebarsjs::Helpers::Case::Human.new)
  config.handlebars.helper(:lamel, Handlebarsjs::Helpers::Case::Lamel.new)
  config.handlebars.helper(:lower, Handlebarsjs::Helpers::Case::Lower.new)
  config.handlebars.helper(:slash, Handlebarsjs::Helpers::Case::Slash.new)
  config.handlebars.helper(:snake, Handlebarsjs::Helpers::Case::Snake.new)
  config.handlebars.helper(:title, Handlebarsjs::Helpers::Case::Title.new)
  config.handlebars.helper(:upper, Handlebarsjs::Helpers::Case::Upper.new)
end
