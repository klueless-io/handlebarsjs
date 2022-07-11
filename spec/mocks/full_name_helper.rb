# frozen_string_literal: true

class FullNameCmdlet
  def call(first, last)
    "#{first} #{last}"
  end
end
class FullNameHelper < Handlebarsjs::BaseHelper
  register_cmdlet(FullNameCmdlet)

  def to_proc
    ->(first, last, _opts) { wrapper(cmdlet.call(first, last)) }
  end
end
