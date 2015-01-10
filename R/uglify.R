#' Uglify or Prettify JavaScript
#'
#' Beautify functions automatically indent code.
#'
#' @export
uglify <- function(text){
  text <- paste(text, collapse = "\n")
  ct$call("UglifyJS.minify", text)
}
