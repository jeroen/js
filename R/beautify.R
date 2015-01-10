#' Beautify html/css/js
#'
#' Beautify functions automatically indent code.
#'
#' @param text string with html, css or javascript code.
#' @param indent_size number of spaces to indent.
#' @param ... additional options, see \href{https://www.npmjs.com/package/js-beautify#optionsy}{npm docs}.
#' @rdname beautify
#' @name beautify
#' @references Documentation of js-beautify on npm: \url{https://www.npmjs.com/package/js-beautify}
#' @export
#' @examples test <- "function(x,y){x=x||1;y=y||1;return x+y;}"
#' cat(beautify_js(test))
beautify_js <- function(text, indent_size = 4, ...){
  text <- paste(text, collapse = "\n")
  opts <- list(...)
  opts$indent_size = indent_size;
  ct$call("beautify.js_beautify", text, opts)
}

#' @rdname beautify
#' @export
beautify_html <- function(text, indent_size = 4, ...){
  text <- paste(text, collapse = "\n")
  opts <- list(...)
  opts$indent_size = indent_size;
  ct$call("beautify.html", text, opts)
}

#' @rdname beautify
#' @export
beautify_css <- function(text, indent_size = 4, ...){
  text <- paste(text, collapse = "\n")
  opts <- list(...)
  opts$indent_size = indent_size;
  ct$call("beautify.css", text, opts)
}