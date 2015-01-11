// add missing minify function into UglifyJS2 browser build
// note: source maps removed, original function here: 
//    https://github.com/mishoo/UglifyJS2/blob/master/tools/node.js#L52 
//
// usage:
// UglifyJS.minify(['var foo = 42;', 'function bar() { return 21; }', 'var baz = 7;']);


UglifyJS.minify = function(codes, options) {

    options = UglifyJS.defaults(options || {}, {
        warnings     : false,
        mangle       : {},
        compress     : {}
    });
    if (typeof codes == "string")
        codes = [ codes ];

    // 1. parse
    var toplevel = null;
    codes.forEach(function(code){
        toplevel = UglifyJS.parse(code, {
            filename: "?",
            toplevel: toplevel
        });
    });

    // 2. compress
    if (options.compress) {
        var compress = { warnings: options.warnings };
        UglifyJS.merge(compress, options.compress);
        toplevel.figure_out_scope();
        var sq = UglifyJS.Compressor(compress);
        toplevel = toplevel.transform(sq);
    }

    // 3. mangle
    if (options.mangle) {
        toplevel.figure_out_scope();
        toplevel.compute_char_frequency();
        toplevel.mangle_names(options.mangle);
    }

    // 4. output
    var stream = UglifyJS.OutputStream();
    toplevel.print(stream);
    return stream.toString();
};

//warning function optional
UglifyJS.AST_Node.warn_function = function(txt) {
    console.warn(txt);
};
