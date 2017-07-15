#' JavaScrip Syntax Tree
#'
#' \href{https://www.npmjs.com/package/esprima}{Esprima} is a high performance, standard-compliant
#' ECMAScript parser. It has full support for ECMAScript 2017 and returns a sensible syntax tree
#' format as standardized by ESTree project.
#'
#' The \code{esprima_tokenize} function returns a data frame with JavaScript tokens. The
#' \code{esprima_parse} function returns the Syntax Tree in JSON format. This can be parsed to R
#' using e.g. \code{jsonlite::fromJSON}.
#'
#' @rdname esprima
#' @name esprima
#' @export
#' @param text a character vector with JavaScript code
#' @param ... additional arguments for the \href{http://esprima.readthedocs.io/en/4.0/lexical-analysis.html}{tokenizer}
#' @references Esprima documentation: \url{http://esprima.readthedocs.io/en/4.0/}.
#' @examples code <- "function test(x, y){ x = x || 1; y = y || 1; return x*y;}"
#' esprima_tokenize(code)
#' esprima_parse(code)
esprima_tokenize <- function(text, ...){
  text <- paste(text, collapse = "\n")
  js_validate_script(text)
  opts <- list(...)
  ct$call("esprima.tokenize", text, opts)
}

#' @export
#' @rdname esprima
esprima_parse <- function(text, ...){
  text <- paste(text, collapse = "\n")
  js_validate_script(text)
  opts <- list(...)
  structure(ct$call("esprima.parse_to_json", text, opts), class = c("json", "character"))
}
