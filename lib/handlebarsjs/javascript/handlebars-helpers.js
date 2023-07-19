// Put any custom helper that you can't get to work directly with Ruby in here.
// Exampe: I have had a lot of trouble getting the block helpers to work with Ruby
// Handlebars.registerHelper('loud', function (input) {
//   return input.toUpperCase()
// })

// Handlebars.registerHelper('allow_html', function (some_html) {
//   return new Handlebars.SafeString(some_html);
// })

Handlebars.registerHelper('omit', function (_options) {
  // return options.fn(this)
  return ''
})
