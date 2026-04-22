#' A convenience function that strips selected attributes of an object.
#' @param x An object.
#' @param which A character object with the attribute name(s) to remove.
#' @return A copy of `x` with the selected attributes removed.
#' @export
stripAttr = function(x, which){
  if (!is.character(which)) stop("which must be of type character")
  attributes(x)[which] = NULL
  return(x)
}
