# frozen_string_literal: true

# Dash: Dash case the characters in the given &#x27;string&#x27;
RSpec.describe Handlebarsjs::Helpers::Case::Dash do
  let(:helper_name) { :dash }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data).squish }

    let(:data) { { value: 'the quick brown fox' } }

    let(:template) { '{{dash value}}' }

    it { is_expected.to eq('the-quick-brown-fox') }
  end
end
