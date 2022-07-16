Handlebars.registerHelper('loud', function (input) {
  return input.toUpperCase()
})

Handlebars.registerHelper('allow_html', function (some_html) {
  return new Handlebars.SafeString(some_html);
})

// Handlebars.registerHelper('i_am_safe_xxx', function (some_html) {
//   some_html = "doe some thing"
//   return new Handlebars.SafeString(some_html);
// })
