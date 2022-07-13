# frozen_string_literal: true

KConfig.configure do |config|
  config.handlebars.helper(:join, Handlebarsjs::Helpers::Array::Join.new)
  config.handlebars.helper(:join_pre, Handlebarsjs::Helpers::Array::JoinPre.new)
  config.handlebars.helper(:join_post, Handlebarsjs::Helpers::Array::JoinPost.new)
end
