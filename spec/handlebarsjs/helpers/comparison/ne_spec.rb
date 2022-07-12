# frozen_string_literal: true

# Ne: Return true if left hand side is NOT equal to right hand side
RSpec.describe Handlebarsjs::Helpers::Comparison::Ne do
  let(:helper_name) { :ne }
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
        {{#if (ne lhs rhs)}}
          true
        {{^}}
          false
        {{/if}}
      TEXT
    end

    context 'nil != nil' do
      it { is_expected.to eq('false') }
    end

    context "'aaa' != 'aaa'" do
      let(:lhs) { 'aaa' }
      let(:rhs) { 'aaa' }

      it { is_expected.to eq('false') }
    end

    context ":aaa != 'aaa'" do
      let(:lhs) { :aaa }
      let(:rhs) { 'aaa' }

      it { is_expected.to eq('false') }
    end

    context "'aaa' != :aaa" do
      let(:lhs) { 'aaa' }
      let(:rhs) { :aaa }

      it { is_expected.to eq('false') }
    end

    context "'aaa' != 'AAA'" do
      let(:lhs) { 'aaa' }
      let(:rhs) { 'AAA' }

      it { is_expected.to eq('true') }
    end

    context "'aaa' != 'bbb'" do
      let(:lhs) { 'aaa' }
      let(:rhs) { 'bbb' }

      it { is_expected.to eq('true') }
    end
  end
end
