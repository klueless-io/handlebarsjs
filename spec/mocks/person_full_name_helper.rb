# frozen_string_literal: true

class PersonFullNameHelper < Handlebarsjs::BaseHelper
  def parse(person)
    "#{person['first']} #{person['last']}"
  end
end
