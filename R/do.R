#' Call a function in shorthand.
#'
#' A convenience function that either: a) applies a function to an input or b) runs a parameterless function. A useful shorthand alternative to piping into an anonymous function (a) or manually removing intermediate objects used in creating an output (b).
#'
#' @param x (Default: `NULL`) An object passed into `f` if `f` is not parameterless.
#' @param f A one-argument or parameterless function. If one-argument, then `f(x)` is returned. Otherwise, `f()` is returned.
#' @return The output of `f(x)` or `f()`, whatever that may be.
#'
#' @export
#'
#' @examples
#' library("tidyverse")
#' library("PipeHelpR")
#'
#' # make some test data
#' set.seed(123)
#' testvector = rnorm(100, mean=10, sd=3)
#'
#' # standardize the vector to mean 0 variance 1
#' testvector %>%
#'   # substract off the arithmetic mean
#'   {\(x)x - mean(x)}() %>%
#'   # divide by empirical standard deviation
#'   {\(y)y / sd(y)}() %>%
#'   # limit output
#'   head()
#' # > [1] -0.71304802 -0.35120270  1.60854170 -0.02179795  0.04259548  1.77983218
#'
#' # do the same but using do() for better readability
#' testvector %>%
#'   do(\(x)x - mean(x)) %>%
#'   do(\(y)y / sd(y)) %>%
#'   head()
#' # > [1] -0.71304802 -0.35120270  1.60854170 -0.02179795  0.04259548  1.77983218
do = function(x=NULL, f){
  if (length(formals(f))==0){
    if (!is.null(x)) warning("`x` was provided but `f` is parameterless, `x` will not be used")
    return(f())
  }
  return(f(x))
}
