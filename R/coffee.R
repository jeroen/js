#' Coffee Script
#'
#' Compiles coffee script into JavaScript.
#'
#' @export
#' @aliases coffee
#' @param code a string with JavaScript code
#' @param ... additional options passed to the compiler
#' @examples # Hello world
#' coffee_compile("square = (x) -> x * x")
#' coffee_compile("square = (x) -> x * x", bare = TRUE)
#'
#' # Simple script
#' demo <- readLines(system.file("example/demo.coffee", package = "js"))
#' js <- coffee_compile(demo)
#' cat(js)
#' cat(uglify_optimize(js))
coffee_compile <- function(code, ...){
  opts <- list(...)
  code <- paste(code, collapse = "\n")
  ct$call("coffee.compile", code, opts)
}
