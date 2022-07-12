# frozen_string_literal: true

# BackSlash: Convert to back slash notation
RSpec.describe Handlebarsjs::Helpers::Case::BackSlash do
  let(:helper_name) { :back_slash }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data).squish }

    let(:data) { { value: 'the quick brown fox' } }

    let(:template) { '{{back_slash value}}' }

    it { is_expected.to eq('the\\quick\\brown\\fox') }
  end
end
