#' Test if code evaluates to a function
#'
#' Simple JavaScript function to test if a piece of code evaluates to a function.
#'
#' @param text JavaScript code
#' @export
is_js_function <- function(text){
  text <- paste(text, collapse = "\n")
  code <- paste("typeof", text)
  validate_js(code, FALSE) && identical("function", try(ct$eval(code), silent = TRUE))
}
