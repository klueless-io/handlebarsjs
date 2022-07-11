# frozen_string_literal: true

class PersonFullNameCmdlet
  def call(person)
    "#{person['first']} #{person['last']}"
  end
end

class PersonFullNameHelper < Handlebarsjs::BaseHelper
  register_cmdlet(PersonFullNameCmdlet)
end
