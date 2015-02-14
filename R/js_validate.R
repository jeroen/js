#' Validate JavaScript
#'
#' Simple wrapper for \code{ct$validate} in \code{\link{V8}}.
#' Tests if code constitutes a syntactically valid JS script.
#'
#' @export
#' @param text character vector with JavaScript code
#' @param error raise error on invalid code
#' @examples js_validate_script("function foo(x){2*x}") #TRUE
#' js_validate_script("foo = function(x){2*x}") #TRUE
#'
#' # Anonymous functions in global scope are invalid
#' js_validate_script("function(x){2*x}", error = FALSE) #FALSE
#'
#' # Use ! or () to check anonymous function syntax
#' js_validate_script("!function(x){2*x}") #TRUE
#' js_validate_script("(function(x){2*x})") #TRUE
js_validate_script <- function(text, error = TRUE){
  res <- ct$validate(text)
  if(error && !res){
    stop("Invalid JavaScript syntax",  call. = FALSE)
  } else {
    return(res)
  }
}
