#' Perform nested `base::sapply()` calls to create a matrix or higher-order array.
#'
#' Takes several iterables and applies a function using every permutation of elements from the iterables as its arguments, returning a vector/matrix/higher dimensional array of the outputs. The shorthand equivalent of making nested `base::sapply()` calls.
#'
#' @param ... Iterable objects that all permutations of elements will be applied over.
#' @param f Function to apply over all permutations of the elements of the `...` arguments.
#' @return A vector, matrix, or higher dimensional array.
#'
#' @export
#'
#' @examples
#' library("tidyverse")
#' library("PipeHelpR")
#'
#' arrapply(1:10, f=\(x)2*x)
#' # > [1]  2  4  6  8 10 12 14 16 18 20
#'
#' # with multiple iterable arguments, it creates a matrix or higher-order array (much like nested `sapply()` calls)
#' arrapply(LETTERS[1:4], letters[1:3], letters[1:2], f=\(x,y,z)paste0(x,y,z))
#' # > , , a
#' # >
#' # >   a     b     c
#' # > A "Aaa" "Aba" "Aca"
#' # > B "Baa" "Bba" "Bca"
#' # > C "Caa" "Cba" "Cca"
#' # > D "Daa" "Dba" "Dca"
#' # >
#' # > , , b
#' # >
#' # >   a     b     c
#' # > A "Aab" "Abb" "Acb"
#' # > B "Bab" "Bbb" "Bcb"
#' # > C "Cab" "Cbb" "Ccb"
#' # > D "Dab" "Dbb" "Dcb"
arrapply = function(..., f){
  args = list(...)
  nargs = length(args)
  # ensure compatible arguments
  if (nargs!=length(formals(f)))
    stop("number of iterables must be equal to number of function arguments")
  if (nargs==0)
    stop("at least 1 iterable required")
  # if using one iterable, simply call sapply()
  if (nargs==1) return(sapply(args[[1]], \(i)f(i)))
  # use recursive sapply() calls for more than one iterable
  g = function(a, b){
    if (length(a)==0) return(do.call(f, b)) # base case, call f() using b as arguments
    # recursive step,
    return(sapply(a[[1]], \(i)g(a[-1], append(b, list(i))), simplify="array"))
  }
  out_noperm = g(args, list())
  ndim = length(dim(out_noperm))
  return(aperm(out_noperm, if (ndim==nargs) nargs:1 else c(ndim:(ndim-nargs+1), 1:(ndim-nargs))))
}
