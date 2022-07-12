# frozen_string_literal: true

# Constant: Constant case the characters in the given &#x27;string&#x27;
RSpec.describe Handlebarsjs::Helpers::Case::Constant do
  let(:helper_name) { :constant }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data).squish }

    let(:data) { { value: 'the quick brown fox' } }

    let(:template) { '{{constant value}}' }

    it { is_expected.to eq('THE_QUICK_BROWN_FOX') }
  end
end
