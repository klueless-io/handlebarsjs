# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
# require 'active_support/core_ext/string'

# require 'handlebars/helpers/base_helper'

module Handlebarsjs
  module Helpers
    # Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.
    module Comparison
      # And: Block helper that renders a block if **all of** the given values are truthy. If an inverse block is specified it will be rendered when falsy.
      # < Handlebars::Helpers::BaseHelper
      class And
        # Parse will And: Block helper that renders a block if **all of** the given values are truthy. If an inverse block is specified it will be rendered when falsy.
        #
        # @example
        #
        # {{#if (and p1 p2 p3 p4 p5)}}
        #   found
        # {{/if}}
        #
        # @example
        #
        # @example
        # {{#if (and name age)}}
        #   {{name}}-{{age}}
        # {{else}}
        #   no name or age
        # {{/if}}
        #
        # @param values list of values (via *splat) to be checked via AND condition
        # @return [String] return block when every value is truthy
        def parse(values)
          values.all? { |value| value }
        end

        def handlebars_helper
          # Exclude last paramater which is the context V8::Object
          proc { |_context, *values| wrapper(parse(values[0..-2])) }
        end
      end
    end
  end
end
