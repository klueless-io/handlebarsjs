// Is this name ok? would compile_and_process_template be better?
// Also, should this be at the top level namespace? 

function compile_template(template) {
  return Handlebars.compile(template);
}

function process_template(template, data) {
  const compiled_template = Handlebars.compile(template);
  return compiled_template(data);
}
