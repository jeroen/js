#' Evaluate JavaScript
#'
#' Evaluate a piece of JavaScript code in a disposable context.
#'
#' @param text JavaScript code
#' @export
#' @examples # Stateless evaluation
#' js_eval("(function() {return 'foo'})()")
#'
#' # Use V8 for stateful evaluation
#' ct <- V8::new_context()
#' ct$eval("var foo = 123")
#' ct$get("foo")
js_eval <- function(text){
  ct <- new_context();
  ct$eval(text)
}
