#' A convenience function that either: a) applies a function to an input or b) runs a parameterless function. A useful shorthand alternative to piping into an anonymous function (a) or manually removing intermediate objects used in creating an output (b).
#' @param x An object passed into `f`. If left NULL (default) then `f` will be called without parameters.
#' @param f A function to apply on `x` or ran without parameters (if `x` is NULL).
#' @return The output of `f(x)`, whatever that may be.
#' @export
do = function(x=NULL, f){
  if (is.null(x)) f() else f(x)
}
