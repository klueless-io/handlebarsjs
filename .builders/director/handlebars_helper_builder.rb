# frozen_string_literal: true

puts 'xxxxxxx'
class HandlebarsHelperBuilder < KDirector::Builders::ActionsBuilder
  attr_reader :current_helper
  # attr_accessor :actions
  # attr_accessor :last_action

  def initialize
    super

    dom[:helpers] = []
    # @actions = []
    # @last_action = {}
  end

  def helpers
    dom[:helpers]
  end

  def add_helper
    @current_helper = new_helper
    dom[:helpers] << current_helper
  end

  def helper_setting(name, value)
    @current_helper[name] = value
  end

  def add_helper_parameter(name, description, splat: false)
    parameter = {
      name: name,
      description: description,
      splat: splat
    }

    @current_helper[:parameters] << parameter
  end

  def add_helper_example(value)
    lines = value.split("\n")
    value = lines.map { |line| "        # #{line.strip}" }.join("\n")

    @current_helper[:examples] << value
  end


  private

  def new_helper
    {
      name: nil,
      description: nil,
      result: nil,
      category: nil,
      category_description: nil,
      base_class_require: nil,
      base_class: nil,
      example_input_value: nil,
      example_output_value: nil,
      test_input_value: nil,
      test_output_value: nil,
      parameters: [],
      examples: []
    }
  end
end
