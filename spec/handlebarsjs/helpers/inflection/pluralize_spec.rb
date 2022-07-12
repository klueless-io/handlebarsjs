# frozen_string_literal: true

# Pluralize: Returns the plural form of the word in the string
RSpec.describe Handlebarsjs::Helpers::Inflection::Pluralize do
  let(:helper_name) { :pluralize }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data).squish }

    let(:data) { { value: value } }

    let(:template) { '{{pluralize value}}' }

    context 'when :string' do
      let(:value) { 'octopus' }

      it { is_expected.to eq('octopi') }
    end

    context 'when :symbol' do
      let(:value) { :octopus }

      it { is_expected.to eq('octopi') }
    end
  end
end
