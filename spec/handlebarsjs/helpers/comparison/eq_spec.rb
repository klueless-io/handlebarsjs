# frozen_string_literal: true

# Eq: Return true if two values are equal
RSpec.describe Handlebarsjs::Helpers::Comparison::Eq do
  let(:helper_name) { :eq }
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
        {{#if (eq lhs rhs)}}
        true
        {{^}}
          false
        {{/if}}
      TEXT
    end

    context 'nil == nil' do
      it { is_expected.to eq('true') }
    end

    context "'aaa' == 'aaa'" do
      let(:lhs) { 'aaa' }
      let(:rhs) { 'aaa' }

      it { is_expected.to eq('true') }
    end

    context ":aaa == 'aaa'" do
      let(:lhs) { :aaa }
      let(:rhs) { 'aaa' }

      it { is_expected.to eq('true') }
    end

    context "'aaa' == :aaa" do
      let(:lhs) { 'aaa' }
      let(:rhs) { :aaa }

      it { is_expected.to eq('true') }
    end

    context "'aaa' == 'AAA'" do
      let(:lhs) { 'aaa' }
      let(:rhs) { 'AAA' }

      it { is_expected.to eq('false') }
    end

    context "'aaa' == 'bbb'" do
      let(:lhs) { 'aaa' }
      let(:rhs) { 'bbb' }

      it { is_expected.to eq('false') }
    end
  end
end
