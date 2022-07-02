# frozen_string_literal: true

RSpec.describe Handlebarsjs::Handlebars do
  let(:instance) { described_class.new }

  context 'initialize' do
    it { is_expected.to be_a described_class }

    it 'should have a snapshot_builder' do
      expect(instance.snapshot_builder).to be_a Handlebarsjs::SnapshotBuilder
    end
  end

  describe '#process_template' do
    subject { instance.process_template(template, data) }

    context 'simple template' do
      let(:template) do
        <<~TEXT.chomp
          Hello {{name}}
        TEXT
      end
  
      let(:data) { { name: 'World' } }

      it { is_expected.to eq("Hello World") }
    end

    context 'handle whitespace suppression' do
      let(:template) do
        <<~TEXT.chomp
          --------    {{~word~}}   --------
        TEXT
      end

      let(:data) { { word: 'HELLO' } }
      
      it { is_expected.to eq("--------HELLO--------") }
    end

    xcontext 'allow Ruby blocks in data' do
      # This example came from Cowboyd, but is not available in RubyRacer from what I can tell
      let(:template) do
        <<~TEXT.chomp
          Hi {{name}}
        TEXT
      end

      let(:data) { { name: ->(_context) { "Mate" } } }

      it { is_expected.to eq("Hi Mate") }
    end
  end
end
