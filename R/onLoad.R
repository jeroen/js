#' @importFrom V8 new_context
ct <- new_context()

.onLoad <- function(libname, pkgname){
  ct$reset()
  libs <- list.files(system.file("lib", package = pkgname), full.names = TRUE, pattern="*.js");
  lapply(sort(libs), function(path){
    ct$source(path)
  })
}
