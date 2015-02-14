#' @importFrom V8 new_context
ct <- NULL

.onLoad <- function(libname, pkgname){
  ct <<- new_context()
  libs <- list.files(system.file("js", package = pkgname), full.names = TRUE, pattern="*.js");
  lapply(sort(libs), function(path){
    ct$source(path)
  })
}
