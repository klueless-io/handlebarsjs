# frozen_string_literal: true

# Upper: Upper case the characters in the given &#x27;string&#x27;
RSpec.describe Handlebarsjs::Helpers::Case::Upper do
  let(:helper_name) { :upper }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data).squish }

    let(:data) { { value: 'the quick brown fox' } }

    let(:template) { '{{upper value}}' }

    it { is_expected.to eq('THE QUICK BROWN FOX') }
  end
end
