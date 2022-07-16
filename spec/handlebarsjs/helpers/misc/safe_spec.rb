# frozen_string_literal: true

# Safe: pass through the value with &lt;&gt; and single and double quotes left as is
RSpec.describe Handlebarsjs::Helpers::Misc::Safe do
  let(:helper_name) { :safe }
  let(:helper) { described_class.new }
  let(:handlebars) { Handlebarsjs::Handlebars.new }

  before { handlebars.handlebars_snapshot.add_helper(helper_name, helper) }

  describe '#process_template' do
    subject { handlebars.process_template(template, data).squish }

    let(:data) { { value: '<hello name="world" />' } }

    let(:template) { '{{safe value}}' }

    it { is_expected.to eq('<hello name="world" />') }
  end
end
