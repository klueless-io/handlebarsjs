# frozen_string_literal: true

require_relative '../mocks/full_name_helper'
require_relative '../mocks/person_full_name_helper'

RSpec.describe Handlebarsjs::HandlebarsConfiguration do
  let(:instance) { described_class.new }
  let(:helper1) { FullNameHelper.new }
  let(:helper2) { PersonFullNameHelper.new }

  subject { instance }

  it { is_expected.to have_attributes(helpers: []) }

  context 'when helper added with' do
    context 'when helper with aliases' do
      before { instance.helper(:freaky, helper1, aliases: %i[thursday friday]) }

      it 'should add helper to helpers' do
        expect(instance.helpers).to eq([
                                         Handlebarsjs::HandlebarsConfiguration::HelperConfig.new(:freaky, helper1),
                                         Handlebarsjs::HandlebarsConfiguration::HelperConfig.new(:thursday, helper1),
                                         Handlebarsjs::HandlebarsConfiguration::HelperConfig.new(:friday, helper1)
                                       ])
      end
    end

    context 'when multiple helpers' do
      before do
        instance.helper(:freaky, helper1)
        instance.helper(:different, helper2)
      end

      it 'should add more helpers including duplicates (aka aliases)' do
        expect(instance.helpers).to eq([
                                         Handlebarsjs::HandlebarsConfiguration::HelperConfig.new(:freaky, helper1),
                                         Handlebarsjs::HandlebarsConfiguration::HelperConfig.new(:different, helper2)
                                       ])
      end
    end
  end
end
