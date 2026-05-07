#' A convenience function that applies a function to an input, a more readable shorthand for "checkpointing" with an anonymous function.
#' @param x An object passed into `f`.
#' @param f A function to apply on `x`.
#' @return The output of `f(x)`, whatever that may be.
#' @export
do = function(x, f){
  return(f(x))
}

#' A convenience function performs a no-argument function, a useful shorthand for using a functional environment to prevent intermediate object leakage into the main environment.
#' @param f A no-argument function to perform.
#' @return The output of `f()`, whatever that may be.
#' @export
do0 = function(f){
  return(f())
}
