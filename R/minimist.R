#' Parse argument options
#'
#' This module is the guts of optimist's argument parser without all the fanciful
#' decoration.
#'
#' Parses a vector of strings (e.g. from \code{\link{commandArgs}}) into the proper key/value list.
#'
#' @export
#' @param args a character vector with arguments
#' @examples minimist()
#' minimist(c("-a", "beep", "-b", "boop"))
#' args = c("-x", "3", "-y", "4", "-n5", "-abc", "--beep=boop", "foo", "bar", "baz")
#' minimist(args)
minimist <- function(args = commandArgs()){
  ct$call("minimist", as.list(args))
}
