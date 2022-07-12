# frozen_string_literal: true

# Lamel: Lower camel case the characters in the given &#x27;string&#x27;
RSpec.describe Handlebarsjs::Helpers::Case::Lamel do
  let(:helper_name) { :lamel }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data).squish }

    let(:data) { { value: 'the quick brown fox' } }

    let(:template) { '{{lamel value}}' }

    it { is_expected.to eq('theQuickBrownFox') }
  end
end
