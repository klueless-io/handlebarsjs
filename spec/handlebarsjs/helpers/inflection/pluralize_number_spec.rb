# frozen_string_literal: true

# PluralizeNumber: Returns the plural form of the word based on a count
RSpec.describe Handlebarsjs::Helpers::Inflection::PluralizeNumber do
  let(:helper_name) { :pluralize_number }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data).squish }

    let(:value) { nil }
    let(:count) { 1 }

    let(:data) { { value: value, count: count } }

    let(:template) { '{{pluralize_number value count}}' }

    context 'when default format' do
      let(:value) { 'person' }
      context 'when one person' do
        let(:count) { 1 }
        it { is_expected.to eq('person') }

        context 'when 2 people' do
          let(:count) { 2 }
          it { is_expected.to eq('people') }
        end
      end
    end
  end
end
