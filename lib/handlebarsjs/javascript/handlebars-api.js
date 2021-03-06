// This function will be needed in future when I can figure out how to cache templates.
// function compile_template(template) {
//   return Handlebars.compile(template);
// }

// This is the main function that is called by the client.
function process_template(template, data) {
  // The process template function may be improved with some type of caching
  const compiled_template = Handlebars.compile(template);
  return compiled_template(data);
}
