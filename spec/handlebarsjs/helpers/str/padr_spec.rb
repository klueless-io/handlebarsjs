# frozen_string_literal: true

# Padr: take the value and give it padding on the right hand side
RSpec.describe Handlebarsjs::Helpers::Str::Padr do
  let(:helper_name) { :padr }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data) }

    let(:value) { nil }
    let(:count) { nil }
    let(:char) { nil }
    let(:data) { { value: value, count: count, char: char } }
    let(:template) { '{{padr value}}' }

    context 'safely handle nil value' do
      it { is_expected.to eq('                              ') }
    end

    context 'when value supplied' do
      let(:value) { 'pad-me' }
      it { is_expected.to eq('pad-me                        ') }
      context 'when value is integer' do
        let(:value) { 123 }
        it { is_expected.to eq('123                           ') }
      end
      context 'when value is symbol' do
        let(:value) { :symbol }
        it { is_expected.to eq('symbol                        ') }
      end
      context 'and padding count' do
        let(:template) { '{{padr value count char}}' }
        let(:count) { 10 }
        it { is_expected.to eq('pad-me    ') }
        context 'and padding character' do
          let(:char) { '-' }
          it { is_expected.to eq('pad-me----') }
          context 'with padding count supplied as string' do
            let(:count) { '8' }
            it { is_expected.to eq('pad-me--') }
          end
        end
      end
    end
  end
end
