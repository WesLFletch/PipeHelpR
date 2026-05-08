#' Set object `row.names` in a pipeline.
#'
#' A convenience function to modify the row names of the passed in object.
#'
#' @param object The object whose row names will be modified.
#' @param nm A character vector containing the new row names for `object`.
#' @return A copy of `object` with its row names changed to `nm`.
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
#' # make a matrix out of the vector, and add row and column names
#' testmatrix = testvector %>%
#'   # make into 10x10 matrix
#'   matrix(nrow=10) %>%
#'   setRownames(LETTERS[1:10])
#'
#' head(testmatrix, c(6,6))
#' # >        [,1]      [,2]     [,3]      [,4]      [,5]      [,6]
#' # > A  8.318573 13.672245 6.796529 11.279393  7.915879 10.759956
#' # > B  9.309468 11.079441 9.346075  9.114786  9.376248  9.914360
#' # > C 14.676125 11.202314 6.921987 12.685377  6.203811  9.871389
#' # > D 10.211525 10.332048 7.813326 12.634400 16.506868 14.105807
#' # > E 10.387863  8.332477 8.124882 12.464743 13.623886  9.322687
#' # > F 15.145195 15.360739 4.939920 12.065921  6.630674 14.549412
setRownames = function(object, nm){
  rownames(object) = nm
  return(object)
}

#' Set object `col.names` in a pipeline.
#'
#' A convenience function to modify the column names of the passed in object.
#'
#' @param object The object whose column names will be modified.
#' @param nm A character vector containing the new column names for `object`.
#' @return A copy of `object` with its column names changed to `nm`.
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
#' # make a matrix out of the vector, and add row and column names
#' testmatrix = testvector %>%
#'   # make into 10x10 matrix
#'   matrix(nrow=10) %>%
#'   setColnames(LETTERS[11:20])
#'
#' head(testmatrix, c(6,6))
#' # >              K         L        M         N         O         P
#' # > [1,]  8.318573 13.672245 6.796529 11.279393  7.915879 10.759956
#' # > [2,]  9.309468 11.079441 9.346075  9.114786  9.376248  9.914360
#' # > [3,] 14.676125 11.202314 6.921987 12.685377  6.203811  9.871389
#' # > [4,] 10.211525 10.332048 7.813326 12.634400 16.506868 14.105807
#' # > [5,] 10.387863  8.332477 8.124882 12.464743 13.623886  9.322687
#' # > [6,] 15.145195 15.360739 4.939920 12.065921  6.630674 14.549412
setColnames = function(object, nm){
  colnames(object) = nm
  return(object)
}

#' Set object `dimnames` in a pipeline.
#'
#' A convenience function to modify the dimension names of the passed in object.
#'
#' @param object The object whose dimension names will be modified.
#' @param ... Either a single list of character vectors or multiple separate character vectors containing the new dimension names for `object`.
#' @return A copy of `object` with its dimension changed to the elements of `...`.
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
#' # make an array out of the vector, and add names for its dimensions
#' testarray = testvector %>%
#'   array(dim=c(4,5,5)) %>%
#'   setDimnames(LETTERS[1:4], LETTERS[5:9], LETTERS[10:14])
#'
#' head(testarray, c(2,2,2))
#' # > , , J
#' # >          E        F
#' # > A 8.318573 10.38786
#' # > B 9.309468 15.14519
#' # >
#' # > , , K
#' # >          E        F
#' # > A 6.796529 8.124882
#' # > B 9.346075 4.939920
setDimnames = function(object, ...){
  nm = list(...)
  dimnames(object) = if (length(nm)==1) nm[[1]] else nm
  return(object)
}
