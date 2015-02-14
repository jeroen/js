#' Get the type of a JavaScript object
#'
#' JavaScript wrapper to \code{typeof} to test if a piece of JavaScript code is
#' syntactically valid, and the type of object it evaluates to. Useful to
#' verify that a piece of JavaScript code contains a proper function/object.
#'
#' @param text JavaScript code
#' @export
#' @examples
#' js_typeof("function(x){return x+1}")
#' js_typeof("(function() {return 'foo'})()")
#' js_typeof("{foo : 123, bar : true}")
js_typeof <- function(text){
  text <- paste(text, collapse = "\n")
  code <- paste("typeof", text)
  type <- ct$eval(code)
  return(type)
}
