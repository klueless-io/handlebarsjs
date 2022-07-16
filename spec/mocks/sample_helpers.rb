# frozen_string_literal: true

class SampleCmdlet
  def initialize(delimiter = '|')
    @delimiter = delimiter
  end

  def call(value)
    "#{@delimiter}#{value}#{@delimiter}"
  end
end

class SampleMultipleParameterCmdlet
  def call(value1, value2)
    "#{value1} #{value2}"
  end
end

class SampleHandlebarsHelper1 < Handlebarsjs::BaseHelper
  register_cmdlet(SampleCmdlet, parameter_names: [:value])
end

class SampleHandlebarsHandler2 < Handlebarsjs::BaseHelper
  def initialize
    super(SampleCmdlet.new('*'), parameter_names: [:value])
  end
end

class SampleMultipleParamaterHandlebarsHelper < Handlebarsjs::BaseHelper
  register_cmdlet(SampleMultipleParameterCmdlet, parameter_names: %i[value1 value2])
end

class SampleSafeStringTrueHelper < Handlebarsjs::BaseHelper
  register_cmdlet(SampleCmdlet, safe: true, parameter_names: %i[value])
end
