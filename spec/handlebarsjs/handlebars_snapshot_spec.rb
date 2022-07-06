# frozen_string_literal: true

RSpec.describe Handlebarsjs::HandlebarsSnapshot do
  let(:instance) { described_class.new }

  context 'initialize' do
    it { is_expected.to be_a described_class }

    context '.scripts' do
      subject { instance.scripts }

      it { is_expected.to be_empty }
    end

    context '.script' do
      subject { instance.script }

      it { is_expected.to be_empty }
    end
  end

  describe '#snapshot' do
    subject { instance.snapshot }

    it { is_expected.to be_a(MiniRacer::Snapshot) }

    it 'same Snapshot is returned when called multiple times' do
      id = instance.snapshot.object_id

      expect(instance.snapshot.object_id).to eq(id)
    end

    it 'new Snapshot is returned if script changes' do
      id = instance.snapshot.object_id

      instance.add_library('handlebars', path: Handlebarsjs::HANDLEBARS_LIBRARY_PATH)

      expect(instance.snapshot.object_id).not_to eq(id)
    end
  end

  describe '#new_context' do
    subject { instance.new_context }

    it { is_expected.to be_a(MiniRacer::Context) }
  end

  describe '#add_helper' do
    subject { instance.helpers }

    it { is_expected.to be_empty }

    it 'adds a helper' do
      callback = ->(name) { "Hello, #{name}!" }
      instance.add_helper('hello', callback)

      expect(subject).to include({ name: 'hello', callback: callback })
    end
  end

  describe '#register_helper' do
    before { instance.register_helper('ymen') }

    describe '#scripts' do
      subject { instance.scripts }

      it { is_expected.to have_attributes(count: 1) }
      it { expect(subject.first).to include(name: 'ymen', type: 'helper', script: "Handlebars.registerHelper('ymen', ruby_ymen)") }
    end
  end

  context 'add handlebars library' do
    before { instance.add_library('handlebars', path: Handlebarsjs::HANDLEBARS_LIBRARY_PATH) }

    describe '#scripts' do
      subject { instance.scripts }

      it { is_expected.to have_attributes(count: 1) }
      it { expect(subject.first).to include(name: 'handlebars', type: 'library', script: include('Copyright (C) 2011-2019 by Yehuda Katz')) }

      context 'when script and helper is present' do
        subject { instance.script }

        before do
          instance.add_library('xmen', script: 'function xmen() { return "xmen" }')
          instance.register_helper('ymen')
        end

        it do
          expect(subject)
            .to include('Copyright (C) 2011-2019 by Yehuda Katz')
            .and include('function xmen() { return "xmen" }')
            .and include("Handlebars.registerHelper('ymen', ruby_ymen)")
        end
      end
    end
  end

  context 'add javascript library' do
    context 'when missing script or file' do
      it 'raises error' do
        expect { instance.add_library('handlebars') }.to raise_error(Handlebarsjs::Error)
      end
    end

    context 'when script and file are present' do
      it 'raises error' do
        expect { instance.add_library('handlebars', script: 'function() {}', path: 'handlebars') }.to raise_error(Handlebarsjs::Error)
      end
    end

    context 'when one library file' do
      before do
        instance.add_library('sample 1', path: 'spec/mocks/sample-library-1.js')
      end

      context '.scripts' do
        subject { instance.scripts }

        it { is_expected.to have_attributes(count: 1) }
        it { expect(subject.first).to include(name: 'sample 1', type: 'library', script: "function sample1() {\n  return \'sample1\';\n}", path: 'spec/mocks/sample-library-1.js') }

        describe '#script' do
          subject { instance.script }

          it { is_expected.to include('function sample1()').and include('// library - sample 1') }
        end

        context 'when two library files' do
          before do
            instance.add_library('sample 2', path: 'spec/mocks/sample-library-2.js')
          end

          it { is_expected.to have_attributes(count: 2) }
          it { expect(subject.first).to include(name: 'sample 1', type: 'library', script: "function sample1() {\n  return \'sample1\';\n}", path: 'spec/mocks/sample-library-1.js') }
          it { expect(subject.last).to include(name: 'sample 2', type: 'library', script: "function sample2() {\n  return \'sample2\';\n}", path: 'spec/mocks/sample-library-2.js') }

          describe '#script' do
            subject { instance.script }

            it { is_expected.to include('function sample1()').and include('// library - sample 1').and include('function sample2()').and include('// library - sample 2') }
          end
        end
      end
    end
  end
end
