# frozen_string_literal: true

RSpec.describe Handlebarsjs do
  it 'has a version number' do
    expect(Handlebarsjs::VERSION).not_to be nil
  end

  it 'has a standard error' do
    expect { raise Handlebarsjs::Error, 'some message' }
      .to raise_error('some message')
  end
end
