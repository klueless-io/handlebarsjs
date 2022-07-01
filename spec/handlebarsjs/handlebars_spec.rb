# frozen_string_literal: true

RSpec.describe Handlebarsjs::Handlebars do
  let(:instance) { described_class.new }

  context 'initialize' do
    it { is_expected.to be_a described_class }
  end
end
