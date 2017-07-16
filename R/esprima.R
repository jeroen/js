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
#' @param range Annotate each token with its zero-based start and end location
#' @param loc Annotate each token with its column and row-based location
#' @param comment Include every line and block comment in the output
#' @references Esprima documentation: \url{http://esprima.readthedocs.io/en/4.0/}.
#' @examples code <- "function test(x, y){ x = x || 1; y = y || 1; return x*y;}"
#' esprima_tokenize(code)
#' esprima_parse(code)
esprima_tokenize <- function(text, range = FALSE, loc = FALSE, comment = FALSE){
  text <- paste(text, collapse = "\n")
  opts <- list(range = range, loc = loc, comment = comment)
  ct$call("esprima.tokenize", text, opts)
}

#' @export
#' @rdname esprima
#' @param jsx Support JSX syntax
#' @param tolerant Tolerate a few cases of syntax errors
#' @param tokens Collect every token
esprima_parse <- function(text, jsx = FALSE, range = FALSE, loc = FALSE, tolerant = FALSE,
                          tokens = FALSE, comment = FALSE){
  text <- paste(text, collapse = "\n")
  opts <- list(jsx = jsx, range = range, loc = loc, tolerant = tolerant, tokens = tokens, comment = comment)
  structure(ct$call("esprima.parse_to_json", text, opts), class = c("json", "character"))
}
