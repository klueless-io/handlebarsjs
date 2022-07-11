# frozen_string_literal: true

RSpec.describe Handlebarsjs::BaseHelper do
  context 'when using a pre registered_cmdlet' do
    let(:instance) { SampleHandlebarsHelper1.new }

    describe '#wrapper' do
      it 'returns the value' do
        expect(instance.wrapper('foo')).to eq('foo')
      end
    end

    describe '#to_proc' do
      it 'returns a proc' do
        expect(instance.to_proc).to be_a(Proc)
      end

      it 'returns a proc that calls the cmdlet' do
        expect(instance.to_proc.call('foo', {})).to eq('|foo|')
      end
    end
  end

  context 'when using a custom cmdlet' do
    let(:instance) { SampleHandler2.new }

    describe '#wrapper' do
      it 'returns the value' do
        expect(instance.wrapper('foo')).to eq('foo')
      end
    end

    describe '#to_proc' do
      it 'returns a proc' do
        expect(instance.to_proc).to be_a(Proc)
      end

      it 'returns a proc that calls the cmdlet' do
        expect(instance.to_proc.call('foo', {})).to eq('*foo*')
      end
    end
  end
end
