#' A convenience function that performs the reverse operation of `base::which()`. May be useful on occasion.
#' @param idx An integer vector containing the `TRUE` indices in the output.
#' @param len An integer that determines the length of the output.
#' @return A logical vector of length `len` with all `idx` indices set to `TRUE` and the rest to `FALSE.`
#' @export
whichInv = function(idx, len){
  if (!is.integer(idx)) stop("idx must be of type integer")
  if (!is.integer(len)) stop("len must be of type integer")
  if (length(len)!=1) stop("len must be of length 1")
  out = rep(F,len)
  out[idx] = T
  out
}
