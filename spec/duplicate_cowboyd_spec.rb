# frozen_string_literal: true
# # frozen_string_literal: true

# RSpec.describe Handlebarsjs do
#   let(:handlebars_path) { 'lib/handlebarsjs/handlebars-4.7.7.js' }
#   let(:handlebars_api_path) { 'lib/handlebarsjs/handlebars-api.js' }
#   let(:handlebars_helpers_path) { 'lib/handlebarsjs/handlebars-helpers.js' }
#   let(:handlebars_js) { File.read(handlebars_path) }
#   let(:handlebars_api_js) { File.read(handlebars_api_path) }
#   let(:handlebars_helpers_js) { File.read(handlebars_helpers_path) }
#   let(:javascript) { [handlebars_js, handlebars_api_js, handlebars_helpers_js].join("\n\n") }
#   let(:snapshot) { MiniRacer::Snapshot.new(javascript) }
#   let(:context) { MiniRacer::Context.new(snapshot: snapshot) }

#   #  # + "\n" + File.read(handlebarsjs_helpers_path) }

#   describe "a simple template" do
#     let(:t) { compile("Hello {{name}}") }
#     it "allows simple subsitution" do
#       t.call(:name => 'World').should eql "Hello World"
#     end

#     it "allows Ruby blocks as a property" do
#       t.call(:name => lambda { |context| ; "Mate" }).should eql "Hello Mate"
#     end

#     it "can use any Ruby object as a context" do
#       t.call(double(:Object, :name => "Flipper")).should eql "Hello Flipper"
#     end
#   end

#   def compile(*args)
#     subject.compile(*args)
#   end

#   def precompile(*args)
#     subject.precompile(*args)
#   end

# end
