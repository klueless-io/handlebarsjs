# frozen_string_literal: true

RSpec.shared_examples 'nil will parse to empty' do
  let(:value) { nil }

  it { is_expected.to eq('') }
end
