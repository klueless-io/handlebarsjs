# frozen_string_literal: true

class HandlebarsHelperChild < KDirector::Directors::ChildDirector
  def initialize(parent, **opts)
    super(parent, **opts)

    builder.add_helper

    # defaults = {
    #   repo_name: opts[:repo_name], # || parent.builder.dom&[:github]&[:repo_name]
    #   username: opts[:username] || default_github_username, # || parent.builder.dom&[:github]&[:username]
    #   organization: opts[:organization] # || parent.builder.dom&[:github]&[:organization]
    # }
  end

  def name(value)
    builder.helper_setting(:name, value)
  end

  def description(value)
    builder.helper_setting(:description, value)
  end

  def result(value)
    builder.helper_setting(:result, value)
  end

  def category(value)
    builder.helper_setting(:category, value)
  end

  def category_description(value)
    builder.helper_setting(:category_description, value)
  end

  # def base_class_require(value)
  #   builder.helper_setting(:base_class_require, value)
  # end

  # def base_class(value)
  #   builder.helper_setting(:base_class, value)
  # end

  # def example_input_value(value)
  #   builder.helper_setting(:example_input_value, value)
  # end

  # def example_output_value(value)
  #   builder.helper_setting(:example_output_value, value)
  # end

  # def test_input_value(value)
  #   builder.helper_setting(:test_input_value, value)
  # end

  # def test_output_value(value)
  #   builder.helper_setting(:test_output_value, value)
  # end

  def parameter(name, description, splat: false)
    builder.add_helper_parameter(name, description, splat: splat)
  end

  def example(value)
    builder.add_helper_example(value)
  end
end
