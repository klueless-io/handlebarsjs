# frozen_string_literal: true

# Lower: Lower case the characters in the given &#x27;string&#x27;
RSpec.describe Handlebarsjs::Helpers::Case::Lower do
  let(:helper_name) { :lower }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data).squish }

    let(:data) { { value: 'THE quick BROWN fox' } }

    let(:template) { '{{lower value}}' }

    it { is_expected.to eq('the quick brown fox') }
  end
end
