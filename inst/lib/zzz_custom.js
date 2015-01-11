/* Extra functions by Jeroen */
UglifyJS.optimize = function(code, opts){
  var ast = UglifyJS.parse(code);
  var compressor = UglifyJS.Compressor(opts);
  ast.figure_out_scope();
  ast = ast.transform(compressor);
  return ast.print_to_string();
}

UglifyJS.reformat = function(code, opts){
  var ast = UglifyJS.parse(code);
  var stream = UglifyJS.OutputStream(opts);
  var code = ast.print(stream);
  return stream.toString();
}
