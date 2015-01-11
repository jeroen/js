#' Uglify or Prettify JavaScript
#'
#' \href{https://www.npmjs.com/package/uglify-js}{UglifyJS} is a JavaScript
#' compressor/minifier written in JavaScript. It also contains tools that allow one
#' to automate working with JavaScript code.
#'
#' @rdname uglify
#' @name uglify
#' @export
#' @param text a character vector with JavaScript code
#' @param opts a list of options passed to the compressor.
#' @examples code <- "function test(x, y){ x = x || 1; y = y || 1; return x*y;}"
#' uglify_compress(code, list(warnings = TRUE))
#'
#' # Get the full AST.
#' code <- "function sum(x, y){ return x + y;}"
#' ast <- uglify_parse(code)
#'
uglify_parse <- function(text){
  text <- paste(text, collapse = "\n")
  stopifnot(ct$validate(text))
  ct$call("UglifyJS.parse", text)
}


#' @rdname uglify
#' @export
uglify_compress <- function(text, opts = list()){
  text <- paste(text, collapse = "\n")
  stopifnot(ct$validate(text))
  ct$call("UglifyJS.minify", text, opts)
}
