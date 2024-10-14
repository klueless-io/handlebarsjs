# Handlebars and Ruby Helper Documentation Guide

## Table of Contents
1. [Introduction](#introduction)
2. [Installation](#installation)
3. [Configuration](#configuration)
4. [Available Helpers](#available-helpers)
   - [String Helpers](#string-helpers)
   - [Array Helpers](#array-helpers)
   - [Comparison Helpers](#comparison-helpers)
   - [Inflection Helpers](#inflection-helpers)
   - [Case Helpers](#case-helpers)
   - [Miscellaneous Helpers](#miscellaneous-helpers)
5. [Advanced Usage](#advanced-usage)
6. [Troubleshooting](#troubleshooting)
7. [Contributing](#contributing)

## Introduction
This guide provides an overview of the available helpers that can be used with Handlebars templates in combination with Ruby backends. These helpers simplify common operations like string transformations, array manipulations, and comparison logic to streamline template creation and data formatting.

## Installation
To use the helpers in your project, add the relevant gem to your `Gemfile` and install it:

```ruby
# Add this line to your Gemfile
gem 'handlebarsjs'

# Run bundle install to install the gem
bundle install
```

## Configuration
You can customize the helpers using a configuration block. Below is an example showing how to configure some settings for your helpers in Ruby:

```ruby
Handlebars.configure do |config|
  config.helper_prefix = 'custom'
  config.auto_escape = true
  # Add other configuration options as needed
end
```

To extend the configuration, you can also register the `HandlebarsConfigurationExtension`:

```ruby
KConfig::Configuration.register(:handlebars, Handlebarsjs::HandlebarsConfigurationExtension)
```

The `HandlebarsConfigurationDefaults` can be used to preload default helpers for each category:

```ruby
Handlebarsjs::HandlebarsConfigurationDefaults.new.add_all_defaults
```

This allows you to pre-configure helpers for arrays, strings, cases, comparisons, and other categories, providing a streamlined setup process for using helpers effectively.

## Available Helpers

### Miscellaneous Helpers

#### Safe
The `safe` helper allows you to output HTML or other special characters without escaping them. This is particularly useful when you want to retain tags or special symbols in your output.

Usage:

```handlebars
{{safe value}}
```

**Example:**

- Input: `<hello name="world" />`
- Output: `<hello name="world" />`

#### FormatJson
The `format_json` helper is used to format a given value into pretty JSON, which is especially helpful for rendering JSON objects in a human-readable way.

Usage:

```handlebars
{{format_json value}}
```

**Example:**

- Input: `"<hello>World</hello>"`
- Output: `"&quot;&lt;hello&gt;World&lt;/hello&gt;&quot;"`

### Array Helpers

#### JoinPost
The `join_post` helper joins an array of elements into a single string with a separator, adding the separator at the end of the string.

Usage:

```handlebars
{{join_post values}}
```

**Example:**

- Input: `[1, 2, 3]`
- Default Separator Output: `1,2,3,`
- Custom Separator: `{{join_post values "|"}}` results in `1|2|3|`

#### Join
The `join` helper joins an array of elements into a single string with a separator.

Usage:

```handlebars
{{join values}}
```

**Example:**

- Input: `[1, 2, 3]`
- Default Separator Output: `1,2,3`
- Custom Separator: `{{join values "|"}}` results in `1|2|3`

#### JoinPre
The `join_pre` helper joins an array of elements into a single string with a separator, adding the separator at the beginning of the string.

Usage:

```handlebars
{{join_pre values}}
```

**Example:**

- Input: `[1, 2, 3]`
- Default Separator Output: `,1,2,3`
- Custom Separator: `{{join_pre values "|"}}` results in `|1|2|3`

### Inflection Helpers

#### Ordinal
The `ordinal` helper adds the appropriate suffix to a number to denote its position in an ordered sequence.

Usage:

```handlebars
{{ordinal value}}
```

**Example:**

- Input: `1`
- Output: `st`

- Input: `2`
- Output: `nd`

#### Ordinalize
The `ordinalize` helper converts a number to its ordinal representation.

Usage:

```handlebars
{{ordinalize value}}
```

**Example:**

- Input: `1`
- Output: `1st`

- Input: `2`
- Output: `2nd`

#### Singularize
The `singularize` helper converts a word to its singular form.

Usage:

```handlebars
{{singularize value}}
```

**Example:**

- Input: `octopi`
- Output: `octopus`

#### Pluralize
The `pluralize` helper converts a word to its plural form.

Usage:

```handlebars
{{pluralize value}}
```

**Example:**

- Input: `octopus`
- Output: `octopi`

### Case Helpers

#### Lower
The `lower` helper converts all characters in a string to lowercase.

Usage:

```handlebars
{{lower value}}
```

**Example:**

- Input: `THE quick BROWN fox`
- Output: `the quick brown fox`

#### Slash
The `slash` helper converts spaces in a string to forward slashes.

Usage:

```handlebars
{{slash value}}
```

**Example:**

- Input: `the quick brown fox`
- Output: `the/quick/brown/fox`

#### Lamel
The `lamel` helper converts a string to lower camel case.

Usage:

```handlebars
{{lamel value}}
```

**Example:**

- Input: `the quick brown fox`
- Output: `theQuickBrownFox`

### Comparison Helpers

#### Lte
The `lte` helper checks if one value is less than or equal to another.

Usage:

```handlebars
{{#if (lte lhs rhs)}} ... {{/if}}
```

**Example:**

- Input: `1 <= 2`
- Output: `true`

#### Eq
The `eq` helper checks if two values are equal.

Usage:

```handlebars
{{#if (eq lhs rhs)}} ... {{/if}}
```

**Example:**

- Input: `'aaa' == 'aaa'`
- Output: `true`

### String Helpers

#### Padl
The `padl` helper adds padding to the left side of a string.

Usage:

```handlebars
{{padl value count char}}
```

**Example:**

- Input: `pad-me` with padding count of `10` and character `-`
- Output: `----pad-me`

#### Padr
The `padr` helper adds padding to the right side of a string.

Usage:

```handlebars
{{padr value count char}}
```

**Example:**

- Input: `pad-me` with padding count of `10` and character `-`
- Output: `pad-me----`

## Advanced Usage
For more advanced usage, such as creating custom helpers or extending functionality, you can use the `register_helper` method. Here’s an example to create a custom helper that returns the current date:

```ruby
handlebars.register_helper(:current_date) do |context|
  Time.now.strftime("%Y-%m-%d")
end
```

In Handlebars template:

```handlebars
<p>Today's Date: {{current_date}}</p>
```

## Troubleshooting
If helpers are not behaving as expected, consider the following tips:

- Ensure that all helpers are registered before compiling the template.
- Verify the input data format matches the expected type for each helper.
- Check for typos in the helper names used in the templates.

## Contributing
We welcome contributions to enhance the available helpers and documentation. Feel free to fork the repository and submit pull requests. Make sure to follow our contribution guidelines available in `CONTRIBUTING.md`.

For any questions or issues, please create an issue on GitHub.

## File Structure

### lib

#### handlebarsjs

##### helpers

###### misc
- format_json.rb
- safe.rb

###### array
- join_pre.rb
- join.rb
- join_post.rb

###### inflection
- singularize.rb
- pluralize.rb
- pluralize_number_word.rb
- ordinal.rb
- pluralize_number.rb
- ordinalize.rb

###### case
- camel.rb
- title.rb
- back_slash.rb
- dot.rb
- constant.rb
- lower.rb
- snake.rb
- dash.rb
- human.rb
- upper.rb
- lamel.rb
- slash.rb
- double_colon.rb

###### comparison
- and.rb
- default.rb
- lt.rb
- gte.rb
- eq.rb
- gt.rb
- or.rb
- ne.rb
- lte.rb

###### str
- padl.rb
- padr.rb