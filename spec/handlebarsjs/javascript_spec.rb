# frozen_string_literal: true

RSpec.describe Handlebarsjs::Javascript do
  let(:instance) { described_class.new }

  context 'initialize' do
    it { is_expected.to be_a described_class }

    it 'should have a snapshot_builder' do
      expect(instance.snapshot_builder).to be_a Handlebarsjs::SnapshotBuilder
    end
  end

  # REFACTOR: This section should be in a base class
  context 'when evaluating javascript' do
    describe '#eval' do
      subject { instance.eval(script) }

      context 'can run native javascript' do
        let(:script) { "'red yellow blue'.split(' ')" }

        it { is_expected.to eq(%w[red yellow blue]) }
      end

      it 'can run native javascript with arguments' do
        instance.eval 'var adder = (a,b)=>a+b;'
        total = instance.eval 'adder(20,22)'

        expect(total).to eq(42)
      end
    end

    describe '#attach' do
      it 'can run native ruby code as if they were javascript' do
        callback = proc do |a, b|
          a + b
        end

        instance.attach('ruby.adder', callback)
        total = instance.eval 'ruby.adder(30,22)'

        expect(total).to eq(52)
      end
    end

    describe '#call' do
      it 'can pass ruby objects to javascript' do
        name = {
          first: 'Sean',
          last: 'Wallace'
        }

        instance.eval('function hello(name) { return "Hello, " + name.first + " " + name.last + "!" }')
        message = instance.call('hello', name)

        expect(message).to eq('Hello, Sean Wallace!')
      end
    end

    describe '#attach, #call' do
      it 'can pass ruby objects to javascript and into a ruby callback' do
        person = {
          first: 'David',
          last: 'Cruwys'
        }

        callback = proc do |data|
          "Salute #{data['first'].upcase} #{data['last'].downcase}"
        end

        instance.attach('hi', callback)
        message = instance.call('hi', person)

        expect(message).to eq('Salute DAVID cruwys')
      end
    end
  end
end
