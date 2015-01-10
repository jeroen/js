#' @importFrom V8 new_context
ct <- new_context()

.onLoad <- function(libname, pkgname){
  ct$reset()
  ct$eval("var _global = this")
  ct$source(system.file("lib/beautify.js", package = pkgname))
  ct$source(system.file("lib/uglifyjs.js", package = pkgname))
  ct$source(system.file("lib/jade.js", package = pkgname))
  ct$source(system.file("lib/minimist.js", package = pkgname))
}
