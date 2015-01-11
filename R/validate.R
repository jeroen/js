#' Validate JavaScript
#'
#' Simple wrapper for \code{ct$validate} in \code{\link{V8}}.
#'
#' @export
#' @name validate
#' @param text character vector with JavaScript
#' @examples validate_js("function foo(x){2*x}") #TRUE
#' validate_js("foo = function(x){2*x}") #TRUE
#'
#' # Anonymous functions in global scope are invalid
#' validate_js("function(x){2*x}") #FALSE
#'
#' # But as argument is OK
#' validate_js("test(function(x){2*x})") #TRUE
validate_js <- function(text){
  ct$validate(text)
}
