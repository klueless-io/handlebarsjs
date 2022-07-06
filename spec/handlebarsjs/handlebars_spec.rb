# frozen_string_literal: true

require_relative '../mocks/full_name_helper'

RSpec.describe Handlebarsjs::Handlebars do
  let(:instance) { described_class.new }

  context 'initialize' do
    it { is_expected.to be_a described_class }

    it 'should have a handlebars_snapshot' do
      expect(instance.handlebars_snapshot).to be_a Handlebarsjs::HandlebarsSnapshot
    end
  end

  describe '#process_template' do
    subject { instance.process_template(template, data) }

    context 'simple template' do
      let(:template) do
        <<~TEXT.chomp
          {{parts.salutation}} {{name}}{{parts.suffix}}
        TEXT
      end

      let(:data) { { name: 'World', parts: { salutation: 'Bonjour', suffix: '!!!' } } }

      it { is_expected.to eq('Bonjour World!!!') }
    end

    context 'handle whitespace suppression' do
      let(:template) do
        <<~TEXT.chomp
          --------    {{~word~}}   --------
        TEXT
      end

      let(:data) { { word: 'HELLO' } }

      it { is_expected.to eq('--------HELLO--------') }
    end

    xcontext 'allow Ruby blocks in data' do
      # This example came from Cowboyd, but is not available in RubyRacer from what I can tell
      let(:template) do
        <<~TEXT.chomp
          Hi {{name}}
        TEXT
      end

      let(:data) { { name: ->(_context) { 'Mate' } } }

      it { is_expected.to eq('Hi Mate') }
    end

    context 'handlebars helpers' do
      let(:template) do
        <<~TEXT.chomp
          Hi {{full_name person}}
        TEXT
      end
      let(:data) { { person: { first: 'David', last: 'Cruwys' } } }

      context 'when JS helper is manually configured' do
        before do
          script = <<~TEXT
            Handlebars.registerHelper('full_name', function(person) {
              return person.first + " " + person.last;
            });
          TEXT
          instance.handlebars_snapshot.add_snippet('full_name', script: script)
        end

        context '.process_template' do
          subject { instance.process_template(template, data) }

          it { is_expected.to eq('Hi David Cruwys') }
        end
      end

      context 'when JS helper is provided by a library' do
        before do
          instance.handlebars_snapshot.add_library('handlebars-helpers', path: 'spec/mocks/sample-helpers.js')
        end

        context '.process_template' do
          subject { instance.process_template(template, data) }

          it { is_expected.to eq('Hi David Cruwys') }
        end
      end

      context 'when Ruby helper provided' do
        before { instance.handlebars_snapshot.add_helper(helper_name, helper) }

        let(:helper_name) { 'full_name' }

        context 'as callback' do
          let(:helper) { ->(person, _opts) { "#{person['first']} #{person['last']}" } }

          context '.process_template' do
            subject { instance.process_template(template, data) }

            it { is_expected.to eq('Hi David Cruwys') }
          end
        end
        context 'as class' do
          let(:helper) { FullNameHelper.new }

          context '.process_template' do
            subject { instance.process_template(template, data) }

            it { is_expected.to eq('Hi David Cruwys') }
          end
        end
      end
    end
  end
end
