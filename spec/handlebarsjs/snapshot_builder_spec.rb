RSpec.describe Handlebarsjs::SnapshotBuilder do
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

  context '#register_helper' do
    before { instance.register_helper('ymen') }
  
    describe '#scripts' do
      subject { instance.scripts }
    
      it { is_expected.to have_attributes(count: 1) }
      it { expect(subject.first).to include(name: 'ymen', type: 'helper', script: "Handlebars.registerHelper('ymen', ruby_ymen)") }
    end
  end

  context 'add handlebars library' do
    before { instance.add_handlebars_js }
  
    describe '#scripts' do
      subject { instance.scripts }
    
      it { is_expected.to have_attributes(count: 1) }
      it { expect(subject.first).to include(name: 'handlebars', type: 'library', script: include('Copyright (C) 2011-2019 by Yehuda Katz')) }

      context 'when script and helper is present' do
        subject { instance.script }
        
        before { 
          instance.add_library('xmen', script: 'function xmen() { return "xmen" }')
          instance.register_helper('ymen')
        }
      
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
        it { expect(subject.first).to include(name: 'sample 1', type: 'library', script: "function sample1() {\n  return \'sample1\';\n}", path: "spec/mocks/sample-library-1.js") }

        describe '#script' do
          subject { instance.script }
        
          it { is_expected.to include("function sample1()").and include("# library - sample 1") }
        end

        context 'when two library files' do
          before do
            instance.add_library('sample 2', path: 'spec/mocks/sample-library-2.js')
          end

          it { is_expected.to have_attributes(count: 2) }
          it { expect(subject.first).to include(name: 'sample 1', type: 'library', script: "function sample1() {\n  return \'sample1\';\n}", path: "spec/mocks/sample-library-1.js") }
          it { expect(subject.last).to include(name: 'sample 2', type: 'library', script: "function sample2() {\n  return \'sample2\';\n}", path: "spec/mocks/sample-library-2.js") }

          describe '#script' do
            subject { instance.script }
          
            it { is_expected.to include("function sample1()").and include("# library - sample 1").and include("function sample2()").and include("# library - sample 2") }
          end
        end
      end
    end
  end
end
