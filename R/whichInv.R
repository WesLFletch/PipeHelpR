#' Perform the functional inverse of `base::which()`.
#'
#' A convenience function that performs the reverse operation of `base::which()`.
#'
#' @param idx An integer vector containing the `TRUE` indices in the output.
#' @param len An integer that determines the length of the output.
#' @return A logical vector of length `len` with all `idx` indices set to `TRUE` and the rest to `FALSE.`
#'
#' @export
#'
#' @examples
#' library("tidyverse")
#' library("PipeHelpR")
#'
#' seq(1, 10, 2) %>%
#'   whichInv(10)
#' # > [1]  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE
whichInv = function(idx, len){
  if (!is.numeric(idx)) stop("idx must be numeric")
  if (!is.numeric(len)) stop("len must be numeric")
  if (length(len)!=1) stop("len must be of length 1")
  out = rep(F,len)
  out[idx] = T
  out
}
