# frozen_string_literal: true

require_relative '../mocks/full_name_helper'
require_relative '../mocks/person_full_name_helper'

RSpec.describe Handlebarsjs::HandlebarsConfigurationExtension do
  let(:k_config) { KConfig }

  let(:cfg) { ->(config) {} }

  let(:instance) { k_config.configuration }

  let(:helper1) { FullNameHelper.new }
  let(:helper2) { PersonFullNameHelper.new }

  before :each do
    k_config.configure(&cfg)
  end
  after :each do
    k_config.reset
  end

  context 'sample usage' do
    subject { instance.handlebars }
    let(:cfg) do
      lambda do |config|
        config.handlebars.helper(:a, helper1)
        config.handlebars.helper(:b, helper1)
        config.handlebars.helper(:c, helper2)
      end
    end

    it do
      expect(subject.helpers).to eq([
                                      Handlebarsjs::HandlebarsConfiguration::HelperConfig.new(:a, helper1),
                                      Handlebarsjs::HandlebarsConfiguration::HelperConfig.new(:b, helper1),
                                      Handlebarsjs::HandlebarsConfiguration::HelperConfig.new(:c, helper2)
                                    ])
    end
  end
end
