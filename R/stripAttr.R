#' Remove object attributes.
#'
#' A convenience function that strips selected attributes of an object.
#'
#' @param x An object.
#' @param which A character object with the attribute name(s) to remove.
#' @return A copy of `x` with the selected attributes removed.
#'
#' @export
#'
#' @examples
#' library("tidyverse")
#' library("PipeHelpR")
#'
#' # make some test data
#' set.seed(123)
#' testarray = rnorm(100, mean=10, sd=3) %>% array(dim=c(4,5,5))
#'
#' # recover the underlying vector from testarray
#' testarray %>% stripAttr("dim") %>% head()
#' # > [1]  8.318573  9.309468 14.676125 10.211525 10.387863 15.145195
stripAttr = function(x, which){
  if (!is.character(which)) stop("which must be of type character")
  attributes(x)[which] = NULL
  return(x)
}
