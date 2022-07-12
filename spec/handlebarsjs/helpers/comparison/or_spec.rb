# frozen_string_literal: true

RSpec.describe Handlebarsjs::Helpers::Comparison::Or do
  let(:helper_name) { :or }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data).squish }

    let(:lhs) { nil }
    let(:rhs) { nil }
    let(:data) { { lhs: lhs, rhs: rhs } }

    let(:template) do
      <<~TEXT.chomp
        {{#if (or lhs rhs)}}
          true
        {{^}}
          false
        {{/if}}
      TEXT
    end

    context 'nil || nil' do
      it { is_expected.to eq('false') }
    end
    context 'data || nil' do
      let(:lhs) { 'data' }
      it { is_expected.to eq('true') }
    end
    context 'nil || data' do
      let(:rhs) { 'data' }
      it { is_expected.to eq('true') }
    end
    context 'data || data' do
      let(:lhs) { 'data' }
      let(:rhs) { 'data' }
      it { is_expected.to eq('true') }
    end
  end
end
