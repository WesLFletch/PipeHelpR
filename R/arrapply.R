#' Takes several iterables and applies a function using every permutation of elements from the iterables as its arguments, returning a vector/matrix/higher dimensional array of the outputs. The shorthand equivalent of making nested `base::sapply()` calls
#' @param ... Iterable objects that all permutations of elements will be applied over.
#' @param f Function to apply over all permutations of the elements of the `...` arguments.
#' @return A vector, matrix, or higher dimensional array.
#' @export
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
  return(aperm(g(args, list()), nargs:1))
}
