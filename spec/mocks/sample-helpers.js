Handlebars.registerHelper('full_name', function(person) {
  return person.first + " " + person.last;
});
