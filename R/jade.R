#' Render Jade Template
#'
#' Jade is a high performance template engine heavily influenced by Haml.
#'
#' @export
#' @references Jade documentation: \url{http://jade-lang.com}
#' @param text string with jade template.
#' @param pretty indent html output.
#' @param locals optional list of variables used in the template.
#' @examples test.jade <- system.file("examples/test.jade", package = "js")
#' html <- jade(readLines(test.jade), pretty = TRUE)
#' cat(html)
jade <- function(text, pretty = FALSE, locals = list()){
  text <- paste(text, collapse = "\n")
  ct$call("function(text, pretty, locals){return jade.compile(text, {pretty:pretty})(locals)}", text, pretty, locals)
}
