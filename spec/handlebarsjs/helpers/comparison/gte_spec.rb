# frozen_string_literal: true

# Gte: Return true if left hand side GREATER THAN or EQUAL TO right hand side
RSpec.describe Handlebarsjs::Helpers::Comparison::Gte do
  let(:helper_name) { :gte }
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
        {{#if (gte lhs rhs)}}
        true
        {{^}}
          false
        {{/if}}
      TEXT
    end

    context 'as number' do
      let(:lhs) { 1 }
      let(:rhs) { 1 }

      context '1 >= 2' do
        let(:rhs) { 2 }
        it { is_expected.to eq('false') }
      end
      context '1 >= 1' do
        it { is_expected.to eq('true') }
      end
      context '1 >= 0' do
        let(:rhs) { 0 }
        it { is_expected.to eq('true') }
      end
    end
    context 'as string' do
      let(:rhs) { 'b' }

      context 'c >= b' do
        let(:lhs) { 'c' }
        it { is_expected.to eq('true') }
      end
      context 'b >= b' do
        let(:lhs) { 'b' }
        it { is_expected.to eq('true') }
      end
      context 'a >= b' do
        let(:lhs) { 'a' }
        it { is_expected.to eq('false') }
      end
    end
  end
end
