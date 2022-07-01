# frozen_string_literal: true

RSpec.describe Handlebarsjs do
  it 'has a version number' do
    expect(Handlebarsjs::VERSION).not_to be nil
  end

  it 'has a standard error' do
    expect { raise Handlebarsjs::Error, 'some message' }
      .to raise_error('some message')
  end

  context 'mini_racer' do
    let(:context) { MiniRacer::Context.new }
    it 'can run native javascript' do
      colors = context.eval <<-JS
      'red yellow blue'.split(' ')
      JS

      expect(colors).to eq(%w[red yellow blue])
    end

    it 'can run native javascript with arguments' do
      context.eval 'var adder = (a,b)=>a+b;'
      total = context.eval 'adder(20,22)'

      expect(total).to eq(42)
    end

    it 'can run native ruby inside javascript with arguments' do
      context.attach('ruby.adder', proc do |a, b|
        a + b
      end)

      total = context.eval 'ruby.adder(30,22)'

      expect(total).to eq(52)
    end

    it 'can pass ruby objects to javascript' do
      name = {
        first: 'Sean',
        last: 'Wallace'
      }

      context.eval('function hello(name) { return "Hello, " + name.first + " " + name.last + "!" }')
      message = context.call('hello', name)

      expect(message).to eq('Hello, Sean Wallace!')
    end
  end

  context 'miniracer with handlebarsjs snapshot' do
    let(:handlebarsjs_path) { 'lib/handlebarsjs/javascript/handlebars-4.7.7.js' }
    let(:handlebarsjs_helpers_path) { 'lib/handlebarsjs/javascript/handlebars-helpers.js' }
    let(:javascript) { "#{File.read(handlebarsjs_path)}\n#{File.read(handlebarsjs_helpers_path)}" }
    let(:snapshot) { MiniRacer::Snapshot.new(javascript) }
    let(:context) { MiniRacer::Context.new(snapshot: snapshot) }

    let(:process_template) do
      <<-JAVASCRIPT

      function process_template(template, data) {
        const compiled_template = Handlebars.compile(template);
        return compiled_template(data);
      }

      JAVASCRIPT
    end

    it 'can run native javascript' do
      colors = context.eval <<-JS
      'red yellow blue'.split(' ')
      JS

      expect(colors).to eq(%w[red yellow blue])
    end

    it 'can execute handlebars template' do
      javascript = <<-JAVASCRIPT

      const template = Handlebars.compile("Hello: {{name}}");
      template({ name: "World" });

      JAVASCRIPT

      output = context.eval(javascript)

      expect(output).to eq('Hello: World')
    end

    it 'can execute handlebars template with javascript nested input' do
      javascript = <<-JAVASCRIPT

      const template = Handlebars.compile("{{person.first_name}} {{person.last_name}}");
      template({ person: { first_name: "David", last_name: "Cruwys" } });

      JAVASCRIPT

      output = context.eval(javascript)

      expect(output).to eq('David Cruwys')
    end

    it 'can execute handlebars template with javascript list input' do
      javascript = <<-JAVASCRIPT

      const template = Handlebars.compile("{{#each people}}{{this.first_name}} {{this.last_name}}\\n{{/each}}");
      template({ people: [{ first_name: "David", last_name: "Cruwys"}, { first_name: "Sean", last_name: "Wallace" }] });

      JAVASCRIPT

      output = context.eval(javascript)

      expect(output).to eq("David Cruwys\nSean Wallace\n")
    end

    it 'can process template with ruby data using handlebars javascript' do
      data = {
        actor1: 'Dog',
        actor2: 'Fox'
      }

      handlebars_template = <<~TEXT
        The quick brown {{data.actor1}} jumps over the lazy {{data.actor2}}
      TEXT

      process_template_script = <<-JAVASCRIPT

      function process_template(template, data) {
        const compiled_template = Handlebars.compile(template);
        return compiled_template(data);
      }

      JAVASCRIPT

      context.eval(process_template_script)
      message = context.call('process_template', handlebars_template, { data: data })

      # puts message
      expect(message).to eq("The quick brown Dog jumps over the lazy Fox\n")
    end

    it 'can execute handlebars template with pre-registered javascript helper' do
      handlebars_template = <<~TEXT
        Hello {{loud name}}
      TEXT

      context.eval(process_template)
      message = context.call('process_template', handlebars_template, { name: 'david' })

      puts message
      expect(message).to eq("Hello DAVID\n")
    end

    it 'can execute handlebars template pre-registered ruby helper' do
      handlebars_template = <<~TEXT
        Hello {{surround name}}
      TEXT

      context.attach('ruby_surround', proc do |a|
        "|#{a}|"
      end)

      context.eval("Handlebars.registerHelper('surround', ruby_surround)")
      context.eval(process_template)
      message = context.call('process_template', handlebars_template, { name: 'david' })

      puts message
      expect(message).to eq("Hello |david|\n")
    end
  end
end
