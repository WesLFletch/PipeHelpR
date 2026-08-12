#' Perform nested `base::sapply()` calls to create a matrix or higher-order array.
#'
#' Takes several iterables and applies a function using every the set-theoretic cross
#' product of elements from the iterables as its arguments, returning a
#' vector/matrix/higher dimensional array of the outputs. It is the shorthand equivalent
#' of making nested `base::sapply()` calls.
#'
#' This function is designed to have an intuitive and predictable output dimension
#' structure. The first dimensions always correspond to the iterables in `...`, and the
#' last dimensions are the dimensions of the returned values of `f()`. If the output is a
#' scalar, then no extra dimensions are added. To guarantee the intuitive output
#' structure, all outputs of `f()` are required to all share common dimensions.
#'
#' Passing the output of an `arrapply()` call into `as.data.frame.table()` is a useful
#' way to tabulate the output into a nicer form.
#'
#' @param ... Iterable objects that all combinations of elements will be applied over.
#' @param f Function to apply over all combinations of the elements of the `...`
#' arguments. The number of arguments must be equal to the number of iterables provided in
#' `...`, and the output of `f()` must always have the same output length/dimensions.
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
  # output dimension validation (the length/dimensions of f(...) must be unchanging for all arguments)
  get_dim = function(x) if (is.array(x)) dim(x) else length(x)
  exp_outdim = get_dim(do.call(f, lapply(args, \(x)x[[1]])))
  # make recursive sapply() calls
  g = function(a, b){
    if (length(a)==0){ # base case, call f() using b as arguments
      # verify output dimensions
      out = do.call(f, b)
      if (!isTRUE(all.equal(get_dim(out), exp_outdim)))
        stop(paste0("dimensions of f(", paste(b, collapse=", "), ") are not consistent with other return dimensions from f(...)"))
      return(out)
    }
    # recursive step, collect arguments one at a time to pass down to base case in nested sapply() calls
    return(sapply(a[[1]], \(i)g(a[-1], append(b, list(i))), simplify="array"))
  }
  out_noperm = g(args, list()) # raw output of the recursion, needs dimension permutation for QOL
  ndim = length(dim(out_noperm))
  noutdim = ndim-nargs
  return(aperm(out_noperm, c((nargs:1)+noutdim, (1:noutdim)[0:noutdim])))
}
