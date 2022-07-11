# frozen_string_literal: true

# base_class_require    'handlebars/helpers/comparison/base_helper'
# base_class            'Handlebars::Helpers::Comparison::BaseHelper'
# example_input_value   'var1 and var2'
# example_output_value  'truthy block'
# test_input_value      'var1 and var2'
# test_output_value     'truthy block'

KManager.action :comparison_helpers do
  action do
    common = OpenStruct.new(
      category_name:          'comparison',
      category_description:   'Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.'
    )
    
    HandlebarsHelperDirector
      .init(k_builder, on_exist: :write, on_action: :execute)
      .helper do
        category              common.category_name
        category_description  common.category_description
        name                  'and'
        description           'And: Block helper that renders a block if **all of** the given values are truthy. If an inverse block is specified it will be rendered when falsy.'
        result                "return block when every value is truthy"
        parameter('values', 'list of values (via *splat) to be checked via AND condition', splat: true)

        example <<-TEXT
          {{#if (and p1 p2 p3 p4 p5)}}
            found
          {{/if}}
        TEXT

        example <<-TEXT
          {{#if (and name age)}}
            {{name}}-{{age}}
          {{else}}
            no name or age
          {{/if}}
        TEXT
      end
      .build_helpers
      .debug
  end
end
