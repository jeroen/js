#' Validate JavaScript
#'
#' Simple wrapper for \code{ct$validate} in \code{\link{V8}}.
#'
#' @export
#' @name validate
#' @param text character vector with JavaScript code
#' @param error raise error on invalid code
#' @examples validate_js("function foo(x){2*x}") #TRUE
#' validate_js("foo = function(x){2*x}") #TRUE
#'
#' # Anonymous functions in global scope are invalid
#' validate_js("function(x){2*x}", error = FALSE) #FALSE
#'
#' # Use ! or () to check anonymous function syntax
#' validate_js("!function(x){2*x}") #TRUE
#' validate_js("(function(x){2*x})") #TRUE
validate_js <- function(text, error = TRUE){
  res <- ct$validate(text)
  if(error && !res){
    stop("Invalid JavaScript syntax",  call. = FALSE)
  } else {
    return(res)
  }
}
