# frozen_string_literal: true

require_relative '../mocks/full_name_helper'
require_relative '../mocks/person_full_name_helper'

RSpec.describe Handlebarsjs::Handlebars do
  let(:instance) { described_class.new }

  context 'initialize' do
    it { is_expected.to be_a described_class }

    context '.handlebars_snapshot' do
      it 'should have a handlebars_snapshot' do
        expect(instance.handlebars_snapshot).to be_a Handlebarsjs::HandlebarsSnapshot
      end

      describe '.scripts' do
        subject { instance.handlebars_snapshot.scripts }

        it { is_expected.to have_attributes(count: 2) }
      end
      describe '.helpers' do
        subject { instance.handlebars_snapshot.helpers }

        it { is_expected.to have_attributes(count: 0) }
      end
    end
  end

  describe '#register_helper_script' do
    subject { described_class.register_helper_script('some_name').squish }

    it { is_expected.to eq("Handlebars.registerHelper('some_name', ruby_some_name)") }
  end

  describe '#register_safe_string_helper_script' do
    subject { described_class.register_safe_string_helper_script('some_name', %i[xxx yyy]).squish }

    it { is_expected.to eq("Handlebars.registerHelper('some_name', function (xxx, yyy, _opts) { return new Handlebars.SafeString(ruby_some_name(xxx, yyy, _opts)); })") }
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

    # xcontext 'allow Ruby blocks in data' do
    #   # This example came from Cowboyd, but is not available in RubyRacer from what I can tell
    #   let(:template) do
    #     <<~TEXT.chomp
    #       Hi {{name}}
    #     TEXT
    #   end

    #   let(:data) { { name: ->(_context) { 'Mate' } } }

    #   it { is_expected.to eq('Hi Mate') }
    # end

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
        let(:name) { 'full_name' }

        context 'as callback' do
          before { instance.handlebars_snapshot.add_callback(name, callback, false, %i[person]) }

          let(:callback) { ->(person, _opts) { "#{person['first']} #{person['last']}" } }

          context '.process_template' do
            subject { instance.process_template(template, data) }

            it { is_expected.to eq('Hi David Cruwys') }
          end
        end

        context 'as helper' do
          before { instance.handlebars_snapshot.add_helper(name, helper) }

          context 'as class with standard methods' do
            let(:helper) { PersonFullNameHelper.new }

            context '.process_template' do
              subject { instance.process_template(template, data) }

              it { is_expected.to eq('Hi David Cruwys') }
            end
          end
          context 'as class with custom methods' do
            let(:helper) { FullNameHelper.new }
            let(:template) { 'Hi {{full_name person.first person.last}}' }

            context '.process_template' do
              subject { instance.process_template(template, data) }

              it { is_expected.to eq('Hi David Cruwys') }
            end
          end
        end
      end
    end
  end

  context 'using configured helpers' do
    before do
      KConfig.configuration.handlebars.helper(:fullname, FullNameHelper.new)
    end
    after do
      KConfig.reset
    end

    subject { instance.process_template(template, data) }

    let(:template) { 'Hi {{fullname first last}}' }

    let(:data) { { first: 'David', last: 'Cruwys' } }

    it { is_expected.to eq('Hi David Cruwys') }

    context 'add helpers' do
      before { KConfig.reset }

      it '-> array helpers' do
        expect { KConfig.configuration.handlebars.defaults.add_array_defaults }.to change { KConfig.configuration.handlebars.helpers.length }
      end

      it '-> case helpers' do
        expect { KConfig.configuration.handlebars.defaults.add_case_defaults }.to change { KConfig.configuration.handlebars.helpers.length }
      end

      it '-> comparison helpers' do
        expect { KConfig.configuration.handlebars.defaults.add_comparison_defaults }.to change { KConfig.configuration.handlebars.helpers.length }
      end

      it '-> inflection helpers' do
        expect { KConfig.configuration.handlebars.defaults.add_inflection_defaults }.to change { KConfig.configuration.handlebars.helpers.length }
      end
    end
  end
end
