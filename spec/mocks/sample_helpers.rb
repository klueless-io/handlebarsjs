# frozen_string_literal: true

class SampleCmdlet
  def initialize(delimiter = '|')
    @delimiter = delimiter
  end

  def call(value)
    "#{@delimiter}#{value}#{@delimiter}"
  end
end

class SampleHandlebarsHelper1 < Handlebarsjs::BaseHelper
  register_cmdlet(SampleCmdlet)
end

class SampleHandler2 < Handlebarsjs::BaseHelper
  def initialize
    super(SampleCmdlet.new('*'))
  end
end
