# frozen_string_literal: true

RSpec.describe Handlebarsjs do
  it 'has a version number' do
    expect(Handlebarsjs::VERSION).not_to be nil
  end

  it 'has a standard error' do
    expect { raise Handlebarsjs::Error, 'some message' }
      .to raise_error('some message')
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

    it 'can execute ruby code from javascript' do
      our_ruby = proc do |name|
        "|#{name}|"
      end

      context.attach('some_ruby', our_ruby)
      message = context.eval('some_ruby("go ricky")')

      expect(message).to eq('|go ricky|')
    end

    it 'can execute handlebars template' do
      javascript = <<-JAVASCRIPT

      const template = Handlebars.compile("Hello: {{name}}");
      template({ name: "World" });

      JAVASCRIPT

      output = context.eval(javascript)

      puts output
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

      puts message
      expect(message).to eq("The quick brown Dog jumps over the lazy Fox\n")
    end

    it 'can execute handlebars template with pre-registered javascript helper' do
      handlebars_template = <<~TEXT
        Hello {{loud name}}
      TEXT

      context.eval(process_template)
      message = context.call('process_template', handlebars_template, { name: 'david' }).squish

      # puts message
      expect(message).to eq('Hello DAVID')
    end

    it 'can execute handlebars template with pre-registered javascript helper using SafeString' do
      handlebars_template = <<~TEXT
        {{allow_html html}}
      TEXT

      context.eval(process_template)
      message = context.call('process_template', handlebars_template, { html: '<hello name="world" />' }).squish

      # puts message
      expect(message).to eq('<hello name="world" />')
    end

    it 'can execute handlebars template using pre-registered ruby helper' do
      handlebars_template = <<~TEXT
        Hello {{surround name}}
      TEXT

      context.attach('ruby_surround', proc do |a|
        "|#{a}|"
      end)

      context.eval("Handlebars.registerHelper('surround', ruby_surround)")
      context.eval(process_template)
      message = context.call('process_template', handlebars_template, { name: 'david' }).squish

      expect(message).to eq('Hello |david|')
      # puts message
    end

    it 'can execute handlebars template pre-registered ruby helper wrapped in SafeString decorator' do
      handlebars_template = <<~TEXT
        {{i_am_safe value1 value2}}
      TEXT

      context.attach('ruby_i_am_safe', proc do |value1, value2|
        "#{value1} #{value2}"
      end)

      javascript_safe_string_helper_wrapper = <<-JAVASCRIPT
        Handlebars.registerHelper('i_am_safe', function (value1, value2) {
          return new Handlebars.SafeString(ruby_i_am_safe(value1, value2));
        })
      JAVASCRIPT

      context.eval(javascript_safe_string_helper_wrapper)
      context.eval(process_template)

      message = context.call('process_template', handlebars_template, { value1: '<hello />', value2: '"NAME"' }).squish

      # puts message
      expect(message).to eq('<hello /> "NAME"')
    end

    it 'can create surround template in javascript' do
      context.eval <<-JAVASCRIPT

      Handlebars.registerHelper("trapped", function(options) {
        return new Handlebars.SafeString('No way forward |' + options.fn(this) + " | no way back");
      });

      JAVASCRIPT

      handlebars_template = '{{#trapped}}I am{{/trapped}}'

      context.eval(process_template)
      message = context.call('process_template', handlebars_template).squish

      expect(message).to eq('No way forward |I am | no way back')
    end

    # I think this is built into the handlebarsjs library, but I'm not sure
    it 'can omit content' do
      handlebars_template = '{{#omit}}Look at me{{/omit}}'
      context.eval(process_template)

      # output = context.eval(process_template)
      message = context.call('process_template', handlebars_template).squish

      expect(message).to be_empty
    end
  end
end
