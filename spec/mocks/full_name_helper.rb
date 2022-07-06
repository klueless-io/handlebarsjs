# frozen_string_literal: true

class FullNameHelper < Handlebarsjs::BaseHelper
  def parse(first, last)
    "#{first} #{last}"
  end

  def to_proc
    ->(first, last, _opts) { wrapper(parse(first, last)) }
  end
end
