#' A convenience function that either: a) applies a function to an input or b) runs a parameterless function. A useful shorthand alternative to piping into an anonymous function (a) or manually removing intermediate objects used in creating an output (b).
#' @param x An object passed into `f` if `f` is not parameterless.
#' @param f A one-argument or parameterless function. If one-argument, then `f(x)` is returned. Otherwise, `f()` is returned.
#' @return The output of `f(x)` or `f()`, whatever that may be.
#' @export
do = function(x=NULL, f){
  if (length(formals(f))==0){
    if (!is.null(x)) warning("`x` was provided but `f` is parameterless, `x` will not be used")
    return(f())
  }
  return(f(x))
}
