# frozen_string_literal: true

# Human: Human case the characters in the given &#x27;string&#x27;
RSpec.describe Handlebarsjs::Helpers::Case::Human do
  let(:helper_name) { :human }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data).squish }

    let(:data) { { value: 'the quick brown fox' } }

    let(:template) { '{{human value}}' }

    it { is_expected.to eq('The quick brown fox') }
  end
end
