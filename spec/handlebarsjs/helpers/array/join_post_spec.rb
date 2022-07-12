# frozen_string_literal: true

# JoinPost: join an array of values with separator as a string and using the separator at the end of string
RSpec.describe Handlebarsjs::Helpers::Array::JoinPost do
  let(:helper_name) { :join_post }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data).squish }

    let(:values) { [1, 2, 3] }
    let(:separator) { '|' }
    let(:data) { { values: values, separator: separator } }

    context 'when default separator' do
      let(:template) { '{{join_post values}}' }

      it { is_expected.to eq('1,2,3,') }
    end

    context 'when custom separator' do
      let(:template) { '{{join_post values separator}}' }

      it { is_expected.to eq('1|2|3|') }
    end
  end
end
