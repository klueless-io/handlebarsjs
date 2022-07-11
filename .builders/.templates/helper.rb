# frozen_string_literal: true

module Handlebarsjs
  module Helpers
    # {{helper.category_description}}
    module {{camel helper.category}}
      # {{helper.description}}
      class And < Handlebarsjs::BaseHelper
        # Parse
        #
{{#each helper.examples}}
        # @example
        #
{{.}}
{{/each}}
        #
{{#each helper.parameters}}
        # @param {{./name}} {{./description}}
{{/each}}
        # @return [String] {{helper.result}}
        def parse({{#each helper.parameters}}{{#if @first }}{{^}}, {{/if}}{{#if splat}}*{{/if}}{{./name}}{{/each}})
          values.all? { |value| value }
        end

        def to_proc
          ->(*values, _opts) { wrapper(parse(values[0..-2])) }
        end
      end
    end
  end
end
