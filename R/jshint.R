#' Static analysis tool for JavaScript
#'
#' JSHint is a community-driven tool to detect errors and potential problems in JavaScript code.
#' It is very flexible so you can easily adjust it to your particular coding guidelines and
#' the environment you expect your code to execute in.
#'
#' @export
#' @param text a string of JavaScript code
#' @param globals a white list of global variables that are not formally defined in the source code
#' @param ... additional jshint \href{http://jshint.com/docs/options/}{configuration options}
#' @return a data frame where each row represents a jshint error or \code{NULL} if there were no errors
#' @examples code = "var foo = 123"
#' jshint(code)
#' jshint(code, asi = TRUE)
jshint <- function(text, ..., globals = NULL){
  text <- paste(text, collapse = "\n")
  ct$call("jshint.run", text, list(...), globals)
}
