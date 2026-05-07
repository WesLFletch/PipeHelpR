index.default = function(object, idx=NA, neg=F){
  if (is.list(idx)){
    if (length(idx)>1) stop("idx as list not permitted for object of type vector/list")
    idx=idx[[1]]
  }
  if (is.character(idx)){
    if (!neg) return(object[idx])
    return(object[!(names(object)%in%idx)])
  }
  if (is.numeric(idx)) return(object[((-1)^(neg))*idx])
  if (is.logical(idx)){
    if (!neg) return(object[idx])
    return(object[!idx])
  }
  stop(paste("no method to handle idx of class", class(object)))
}

index.array = function(object, idx=rep(list(NA),length(dim(object))), neg=F){
  if (!is.list(idx)) stop("idx must be list for object of type array/matrix/data.frame")
  if (length(dim(object))!=length(idx)) stop("number of dimensions of object not equal to length of idx")
  if (length(neg)==1) neg=rep(neg,length(idx))
  if (length(neg)!=length(idx)) stop("length of neg is not 1 nor equal to number of dimensions of object")
  idx2 = lapply(1:length(idx), \(i){
    if (any(is.na(idx[[i]]))) return(T)
    if (is.character(idx[[i]])){
      if (!neg[i]) return(idx[[i]])
      return(dimnames(object)[[i]][!(dimnames(object)[[i]]%in%idx[[i]])])
    }
    if (is.numeric(idx[[i]])) return(((-1)^(neg[i]))*idx[[i]])
    if (is.logical(idx[[i]])){
      if (!neg[i]) return(idx[[i]])
      return(!idx[[i]])
    }
    stop("idx must be a list of only character/numeric/logical type")
  })
  do.call(`[`, append(idx2, list(object), after=0))
}

#' Perform general indexing in a pipeline.
#'
#' A convenience function that performs indexing on many general objects with many possible methods, and allows for negative indexing regardless of indexing type.
#'
#' @param object The object to perform the indexing upon.
#' @param idx If `object` is unidimensional, an integer/character/logical vector--or singleton list with such a vector--to use in indexing `object`; otherwise, a list of integer/character/logical vectors to use in indexing each dimension. To keep all indices in a certain dimension, use `NA`.
#' @param neg (Default: `FALSE`) A logical vector that determines whether to use negative indexing or not. If `object` is multidimensional, negative indexing can be used for certain dimensions and not others by making this argument a vector.
#' @return A copy of `object` indexed accordingly.
#'
#' @export
#'
#' @examples
#' library("tidyverse")
#' library("PipeHelpR")
#'
#' # make some test data
#' set.seed(123)
#' testmatrix = rnorm(100, mean=10, sd=3) %>%
#'   # make into 10x10 matrix
#'   matrix(nrow=10) %>%
#'   setRownames(LETTERS[1:10]) %>%
#'   setColnames(LETTERS[11:20])
#'
#' # indexing can be done in a pipeline
#' testmatrix %>%
#'   `+`(10) %>%
#'   index(list(c("A","C"), NA)) # NA is used for an empty index ("get all columns")
#' # >          K        L        M        N        O        P        Q        R        S        T
#' # > A 18.31857 23.67225 16.79653 21.27939 17.91588 20.75996 21.13892 18.52691 20.01729 22.98051
#' # > C 24.67612 21.20231 16.92199 22.68538 16.20381 19.87139 19.00038 23.01722 18.88802 20.71620
#'
#' # negative indexing can be done with characters!
#' testmatrix %>%
#'   `*`(2) %>%
#'   # negative indexing for the first dimension, normal indexing for the second
#'   index(list(c("E","F","G","H","I","J"), 10:9), neg=c(T,F))
#' # >          T        S
#' # > A 25.96102 20.03459
#' # > B 23.29038 22.31168
#' # > C 21.43239 17.77604
#' # > D 16.23256 23.86626
index = function(object, idx=NA, neg=F){
  if (is.array(object)||"data.frame"%in%class(object)) return(index.array(object, idx, neg))
  if (is.vector(object)||is.list(object)) return(index.default(object, idx, neg))
  stop(paste("no method to handle object of class", class(object)))
}

#' Perform (multi-level) list indexing in a pipeline.
#'
#' A convenience function that performs list single-element indexing, and permits indexing at multiple levels.
#'
#' @param object The list to perform the indexing upon.
#' @param idx A list or vector of integer/character objects to use in indexing `object`.
#' @return A copy of `object` indexed accordingly.
#'
#' @export
#'
#' @examples
#' library("tidyverse")
#' library("PipeHelpR")
#' testlist = list(
#'   a = list(c = 1, d = 2),
#'   b = list(e = 3, f = 4)
#' )
#' testlist %>% lindex("a")
#' # > $c
#' # > [1] 1
#' # > $d
#' # > [1] 2
#' testlist %>% lindex(list(2, "e"))
#' # > [1] 3
lindex = function(object, idx){
  if (length(idx)==0) return(object)
  if ("data.frame"%in%class(object)) return(object[[idx]])
  if (is.list(idx)) return(lindex(object[[idx[[1]]]], utils::tail(idx,-1)))
  return(lindex(object[[idx[1]]], utils::tail(idx,-1)))
}
