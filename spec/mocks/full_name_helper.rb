# frozen_string_literal: true

class FullNameHelper < Handlebarsjs::BaseHelper
  def parse(person)
    "#{person['first']} #{person['last']}"
  end
end
