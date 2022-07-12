# frozen_string_literal: true

# Ordinalize: Turns a number into an ordinal string used to denote the position in an ordered sequence such as 1st, 2nd, 3rd, 4th.
RSpec.describe Handlebarsjs::Helpers::Inflection::Ordinalize do
  let(:helper_name) { :ordinalize }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data).squish }

    let(:data) { { value: value } }

    let(:template) { '{{ordinalize value}}' }

    context 'when integer' do
      context 'when 1' do
        let(:value) { 1 }
        it { is_expected.to eq('1st') }
      end
      context 'when 2' do
        let(:value) { 2 }
        it { is_expected.to eq('2nd') }
      end
      context 'when 3' do
        let(:value) { 3 }
        it { is_expected.to eq('3rd') }
      end
      context 'when 4' do
        let(:value) { 4 }
        it { is_expected.to eq('4th') }
      end
      context 'when 1001' do
        let(:value) { 1001 }
        it { is_expected.to eq('1001st') }
      end
    end

    context 'when string number' do
      context 'when 1' do
        let(:value) { '1' }
        it { is_expected.to eq('1st') }
      end
    end
  end
end
