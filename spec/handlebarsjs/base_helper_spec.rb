# frozen_string_literal: true

require_relative '../mocks/sample_helpers'

RSpec.describe Handlebarsjs::BaseHelper do
  context 'when using a pre registered_cmdlet' do
    let(:instance) { SampleHandlebarsHelper1.new }

    describe '#to_proc' do
      it 'returns a proc' do
        expect(instance.to_proc).to be_a(Proc)
      end

      it 'returns a proc that calls the cmdlet' do
        expect(instance.to_proc.call('foo', {})).to eq('|foo|')
      end
    end

    describe '#parameter_names' do
      subject { instance.parameter_names }

      it { is_expected.to eq([:value]) }
    end

    describe '#safe' do
      subject { instance.safe }

      it { is_expected.to be_falsey }
    end

    # describe '#build_register_helper_script' do
    #   context 'when safe is false' do
    #     subject { instance.build_register_helper_script('some_name').squish }

    #     it { is_expected.to eq("Handlebars.registerHelper('some_name', ruby_some_name)") }
    #   end

    #   context 'when safe is true' do
    #     subject { instance.build_register_helper_script('some_name', safe: true).squish }

    #     it { is_expected.to eq("Handlebars.registerHelper('some_name', function (value, _opts) { return new Handlebars.SafeString(ruby_some_name(value, _opts)); })") }
    #   end

    #   context 'when helper has more paramaters' do
    #     let(:instance) { SampleMultipleParamaterHandlebarsHelper.new }

    #     context 'when safe is false' do
    #       subject { instance.build_register_helper_script('some_name').squish }

    #       it { is_expected.to eq("Handlebars.registerHelper('some_name', ruby_some_name)") }
    #     end

    #     context 'when safe is true' do
    #       subject { instance.build_register_helper_script('some_name', safe: true).squish }

    #       it { is_expected.to eq("Handlebars.registerHelper('some_name', function (value1, value2, _opts) { return new Handlebars.SafeString(ruby_some_name(value1, value2, _opts)); })") }
    #     end
    #   end
    # end
  end

  context 'when using a custom cmdlet' do
    let(:instance) { SampleHandlebarsHandler2.new }

    describe '#to_proc' do
      it 'returns a proc' do
        expect(instance.to_proc).to be_a(Proc)
      end

      it 'returns a proc that calls the cmdlet' do
        expect(instance.to_proc.call('foo', {})).to eq('*foo*')
      end

      describe '#parameter_names' do
        it 'returns the parameter names' do
          expect(instance.parameter_names).to eq([:value])
        end
      end

      describe '#safe' do
        subject { instance.safe }

        it { is_expected.to be_falsey }

        context 'when safe is true' do
          let(:instance) { SampleSafeStringTrueHelper.new }

          it { is_expected.to be_truthy }
        end
      end
    end

    # describe '#build_register_helper_script' do
    #   context 'when safe is false' do
    #     subject { instance.build_register_helper_script('xmen').squish }

    #     it { is_expected.to eq("Handlebars.registerHelper('xmen', ruby_xmen)") }
    #   end

    #   context 'when safe is true' do
    #     subject { instance.build_register_helper_script('xmen', safe: true).squish }

    #     it { is_expected.to eq("Handlebars.registerHelper('xmen', function (value, _opts) { return new Handlebars.SafeString(ruby_xmen(value, _opts)); })") }
    #   end
    # end
  end
end
