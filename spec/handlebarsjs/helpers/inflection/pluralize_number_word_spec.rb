# frozen_string_literal: true

# PluralizeNumberWord: Returns the plural form of the word based on a count with the count prefixed in the format &quot;3 categories&quot;
RSpec.describe Handlebarsjs::Helpers::Inflection::PluralizeNumberWord do
  let(:helper_name) { :pluralize_number_word }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data).squish }

    let(:value) { nil }
    let(:count) { 1 }

    let(:data) { { value: value, count: count } }

    let(:template) { '{{pluralize_number_word value count}}' }

    context 'when default format' do
      let(:value) { 'person' }
      context 'when one person' do
        let(:count) { 1 }
        it { is_expected.to eq('1 person') }

        context 'when 2 people' do
          let(:count) { 2 }
          it { is_expected.to eq('2 people') }
        end
      end
    end
  end
end
