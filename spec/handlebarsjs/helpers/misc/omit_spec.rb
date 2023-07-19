# frozen_string_literal: true

# Omit: this content will not get written out, useful for commenting out code
RSpec.describe Handlebarsjs::Helpers::Misc::Omit do
  let(:helper_name) { :omit }
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
