/* Extra functions by Jeroen */
UglifyJS.optimize = function(code, opts){
  var ast = UglifyJS.parse(code);
  var compressor = UglifyJS.Compressor(opts);
  ast.figure_out_scope();
  ast = ast.transform(compressor);
  return ast.print_to_string();
};

UglifyJS.reformat = function(code, opts){
  var ast = UglifyJS.parse(code);
  var stream = UglifyJS.OutputStream(opts);
  ast.print(stream);
  return stream.toString();
};

jshint.run = function(a,b,c) {
  var err = jshint.JSHINT(a,b,c);
  return err ? null : jshint.JSHINT.errors;
};

esprima.parse_to_json = function(str, config){
  return JSON.stringify(esprima.parseScript(str, config), null, 2);
};
