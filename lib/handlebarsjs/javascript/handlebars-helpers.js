Handlebars.registerHelper('loud', function (input) {
  return input.toUpperCase()
})

Handlebars.registerHelper('allow_html', function (some_html) {
  return new Handlebars.SafeString(some_html);
})

