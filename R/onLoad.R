#' @importFrom V8 new_context
ct <- new_context()

.onLoad <- function(libname, pkgname){
  ct$reset()
  ct$source(system.file("lib/beautify.js", package = pkgname))
  ct$source(system.file("lib/uglify.js", package = pkgname))
  ct$source(system.file("lib/jade.js", package = pkgname))
  ct$source(system.file("lib/minimist.js", package = pkgname))
  ct$source(system.file("lib/uglifyjs2-browser-minify.js", package = pkgname))
}
