# frozen_string_literal: true

# Singularize: The reverse of #pluralize, returns the singular form of a word in a string
RSpec.describe Handlebarsjs::Helpers::Inflection::Singularize do
  let(:helper_name) { :singularize }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data).squish }

    let(:data) { { value: value } }

    let(:template) { '{{singularize value}}' }

    context 'when :string' do
      let(:value) { 'octopi' }

      it { is_expected.to eq('octopus') }
    end

    context 'when :symbol' do
      let(:value) { :octopi }

      it { is_expected.to eq('octopus') }
    end
  end
end
