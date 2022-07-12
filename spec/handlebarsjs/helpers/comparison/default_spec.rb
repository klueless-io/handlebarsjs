# frozen_string_literal: true

# Default: Return true if **all of** the given values are truthy.
RSpec.describe Handlebarsjs::Helpers::Comparison::Default do
  let(:helper_name) { :default }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data).squish }

    let(:sad) { 'sad' }
    let(:bad) { 'bad' }
    let(:data) { { sad: sad, bad: bad } }

    context 'only default value provided' do
      let(:template) { '{{default "happy"}}' }

      it { is_expected.to eq('happy') }
    end

    context 'value and default value' do
      let(:template) { '{{default sad "happy"}}' }

      it { is_expected.to eq('sad') }

      context 'when first value is missing' do
        let(:sad) { nil }

        it { is_expected.to eq('happy') }
      end
    end

    context 'list of values and default value' do
      let(:template) { '{{default sad bad "happy"}}' }

      it { is_expected.to eq('sad') }

      context 'when first value is missing' do
        let(:sad) { nil }

        it { is_expected.to eq('bad') }
      end

      context 'when first and second value is missing' do
        let(:sad) { nil }
        let(:bad) { nil }

        it { is_expected.to eq('happy') }
      end
    end
  end
end
