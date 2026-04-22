#' A convenience function to modify the row names of the passed in object.
#' @param object The object whose row names will be modified.
#' @param nm A character vector containing the new row names for `object`.
#' @return A copy of `object` with its row names changed to `nm`.
#' @export
setRownames = function(object, nm){
  rownames(object)=nm
  object
}

#' A convenience function to modify the column names of the passed in object.
#' @param object The object whose column names will be modified.
#' @param nm A character vector containing the new column names for `object`.
#' @return A copy of `object` with its column names changed to `nm`.
#' @export
setColnames = function(object, nm){
  colnames(object)=nm
  object
}

#' A convenience function to modify the dimension names of the passed in object.
#' @param object The object whose dimension names will be modified.
#' @param nm A list of character vectors containing the new dimension names for `object`.
#' @return A copy of `object` with its dimension changed to the elements of `nm`.
#' @export
setDimnames = function(object, nm){
  dimnames(object)=nm
  object
}
