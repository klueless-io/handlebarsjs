# frozen_string_literal: true

# FormatJson: FormatJson will take an object and write it out as pretty JSON
RSpec.describe Handlebarsjs::Helpers::Misc::FormatJson do
  let(:helper_name) { :format_json }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data).squish }

    let(:lhs) { nil }
    let(:rhs) { nil }
    let(:data) { { lhs: lhs, rhs: rhs } }

    let(:template) do
      ''.chomp
    end
  end
end
