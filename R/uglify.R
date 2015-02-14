#' Compress and Reformat JavaScript Code
#'
#' \href{https://www.npmjs.com/package/uglify-js}{UglifyJS} is a JavaScript
#' compressor/minifier written in JavaScript. It also contains tools that allow one
#' to automate working with JavaScript code.
#'
#' @rdname uglify
#' @name uglify
#' @export
#' @param text a character vector with JavaScript code
#' @param beautify prettify (instead of minify) code
#' @param ... additional arguments for the \href{http://lisperator.net/uglifyjs/compress}{optimizer}
#'  or \href{http://lisperator.net/uglifyjs/codegen}{generator}.
#' @references UglifyJS2 Documentation: \url{http://lisperator.net/uglifyjs/}.
#' @examples code <- "function test(x, y){ x = x || 1; y = y || 1; return x*y;}"
#' cat(uglify_optimize(code))
#' cat(uglify_reformat(code, beautify = TRUE, indent_level = 2))
uglify_reformat <- function(text, beautify = FALSE, ...){
  text <- paste(text, collapse = "\n")
  js_validate_script(text)
  opts <- list(...)
  opts$beautify = beautify;
  ct$call("UglifyJS.reformat", text, opts)
}

#' @rdname uglify
#' @export
uglify_optimize <- function(text, ...){
  text <- paste(text, collapse = "\n")
  js_validate_script(text)
  opts <- list(...)
  ct$call("UglifyJS.optimize", text, opts)
}
