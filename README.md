# PipeHelpR

Shorthand helpers for pipelined development in R

Maintained by Wesley Fletcher (weslfletch@gmail.com)

Best coding practice in R minimizes the use of mutable states, as modifying objects' internal states can be the source of many bugs. So, old workflows involved saving intermediate states in a sequence under different variable names. This is very memory inneficient. With the introduction of piping with the `magrittr` package (included in the `tidyverse` package family), it became possible to construct a highly readable and more memory efficient data pipeline, but there were still cases in which using intermediate object forms was required (e.g. changing object attributes and other metadata). Although `PipeHelpR` does not completely resolve these issues, it is a small (but important!) step forward towards cutting out intermediate objects from our workflows entirely.

The philosophy behind this package is that when inevitably required to use intermediate forms, it is preferred to "take advantage of" (or more honestly, borderline abuse) R's function environments instead of the main environment to perform these mutable state changes. This way, mutability is done in moderation and does not contaminate the main environment.

In short, this package defines various helper functions for facilitating simpler, more readable, and memory efficient pipelining (as it pertains to R's memory management and garbage collection). All of the functions are very simple, but using them well can dramatically improve your code workflows.

## Quick Start Guide

Installation can be done using the `devtools` package by running

```{R}
devtools::install_github("WesLFletch/PipeHelpR")
```

Then to use the package in an active R session, run

```{R}
library("PipeHelpR")
```

and you're good to go!

## Examples

The main functionality of this package is illustrated through the below examples.

```{R}
# setup
library("tidyverse")
library("PipeHelpR")

set.seed(123)

# some testing data
testvector = rnorm(100, mean=10, sd=3)
```

Using `do()` is a more readable alternative to piping through a bare anonymous function.
```{R}
# standardize the vector to mean 0 variance 1
testvector %>%
  # substract off the arithmetic mean
  {\(x)x - mean(x)}() %>%
  # divide by empirical standard deviation
  {\(y)y / sd(y)}() %>%
  # limit output
  head()
# > [1] -0.71304802 -0.35120270  1.60854170 -0.02179795  0.04259548  1.77983218
#
# do the same but using do() for better readability
testvector %>%
  do(\(x)x - mean(x)) %>%
  do(\(y)y / sd(y)) %>%
  head()
# > [1] -0.71304802 -0.35120270  1.60854170 -0.02179795  0.04259548  1.77983218
```

`setRownames()`, `setColnames()`, and `setDimnames()` are higher dimension analogs to the native `setNames()`.

```{R}
# make a matrix out of the vector, and add row and column names
testmatrix = testvector %>%
  # make into 10x10 matrix
  matrix(nrow=10) %>%
  setRownames(LETTERS[1:10]) %>%
  setColnames(LETTERS[11:20])
head(testmatrix, c(6,6))
# >           K         L        M         N         O         P
# > A  8.318573 13.672245 6.796529 11.279393  7.915879 10.759956
# > B  9.309468 11.079441 9.346075  9.114786  9.376248  9.914360
# > C 14.676125 11.202314 6.921987 12.685377  6.203811  9.871389
# > D 10.211525 10.332048 7.813326 12.634400 16.506868 14.105807
# > E 10.387863  8.332477 8.124882 12.464743 13.623886  9.322687
# > F 15.145195 15.360739 4.939920 12.065921  6.630674 14.549412

# make an array out of the vector, and add names for its dimensions
testarray = testvector %>%
  array(dim=c(4,5,5)) %>%
  setDimnames(list(LETTERS[1:4], LETTERS[5:9], LETTERS[10:14]))
head(testarray, c(2,2,2))
# > , , J
# >          E        F
# > A 8.318573 10.38786
# > B 9.309468 15.14519
# > 
# > , , K
# >          E        F
# > A 6.796529 8.124882
# > B 9.346075 4.939920
```

With these new objects, we can index them flexibly with `index()` after doing operations on them.

```{R}
testmatrix %>%
  `+`(10) %>%
  index(list(c("A","C"), NA)) # NA is used for an empty index ("get all columns")
# >          K        L        M        N        O        P        Q        R        S        T
# > A 18.31857 23.67225 16.79653 21.27939 17.91588 20.75996 21.13892 18.52691 20.01729 22.98051
# > C 24.67612 21.20231 16.92199 22.68538 16.20381 19.87139 19.00038 23.01722 18.88802 20.71620
```

Negative indexing can be done with characters!

```{R}
testmatrix %>%
  `*`(2) %>%
  # negative indexing for the first dimension, normal indexing for the second
  index(list(c("E","F","G","H","I","J"), 10:9), neg=c(T,F))
# >          T        S
# > A 25.96102 20.03459
# > B 23.29038 22.31168
# > C 21.43239 17.77604
# > D 16.23256 23.86626
```

Recursive list indexing is possible with `lindex()`.

```{R}
testlist = list(
  a = list(c = 1, d = 2),
  b = list(e = 3, f = 4)
)
testlist %>% lindex("a")
# > $c
# > [1] 1
# > $d
# > [1] 2
testlist %>% lindex(list(2, "e"))
# > [1] 3
```

`stripAttr()` can remove attributes from objects.

```{R}
# recover the original vector from testarray
testarray %>% stripAttr(c("dim", "dimnames")) %>% head()
# > [1]  8.318573  9.309468 14.676125 10.211525 10.387863 15.145195
```

`whichInv()` makes a binary vector from an integer vector, the functional inverse of the native `which()`.

```{R}
seq(1L, 10L, 2L) %>%
  whichInv(10L)
# > [1]  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE
```

## Helpful Tips

1. This package defines the function `do()`. For users of the phenomenal `tidyverse` family of R packages (which is remarkably useful in conjunction with `PipeHelpR`!), this will conflict with the `dplyr` package's function `do()`. However, since `dplyr`'s function is now superceded by other functions, we use the same function name. If using `dplyr` or the `tidyverse` in conjunction with this package, I would advise loading their packages before `PipeHelpR` so that `PipeHelpR`'s definition will mask `dplyr`'s.

```{R}
library("tidyverse")
library("PipeHelpR")
```

2. Using `do()` as an isolated code environment is highly recommended for messy data pipelines with many intermediate objects, as well as "checkpointing" intermediate object representations in a pipeline. Two examples below illustrate these specific use cases.

```{R}
library("tidyverse")
library("PipeHelpR")

# some dummy data
testdata = tibble(
  name = c("Alice", "Bob", "Charlie"),
  gender = c("F", "M", "M"),
  height_in = c(63, 71, 73),
  weight_lb = c(140, 190, 177)
)

# calculate each person's BMI = weight_kg / (height_m)^2
testdata %>%
  # convert height and weight
  mutate(
    height_m = height_in/39.37,
    weight_kg = weight_lb/2.205
  ) %>%
  # perform the BMI calculation
  do(\(intermediate_form){ # this is "checkpointing" our manipulations as intermediate_form
    intermediate_form$weight_kg / (intermediate_form$height_m)^2
  })
# > [1] 24.79529 26.49471 23.34801

# do the same but with intermediate objects in a do() functional environment
do(f=\(){
  # convert height and weight
  height_m = testdata$height_in/39.37
  weight_kg = testdata$weight_lb/2.205
  # output the BMI calculation
  weight_kg / (height_m)^2
})
# > [1] 24.79529 26.49471 23.34801

# and we have no intermediate objects left in memory either way!
```

3. Although the shorthand helpers can prevent the storage of unneeded intermediate forms in the main environment, we can modify object states using `do()`. An example below illustrates generating a random symmetric matrix without storing any intermediate objects in the main environment.

```{R}
library("tidyverse")
library("PipeHelpR")

set.seed(123)

matrix(rnorm(9), nrow=3) %>%
  # this generated matrix is "checkpointed" as mat for use in a function environment
  do(\(mat){mat[lower.tri(mat)] = t(mat)[lower.tri(mat)] ; mat})
# >             [,1]        [,2]       [,3]
# > [1,] -0.56047565  0.07050839  0.4609162
# > [2,]  0.07050839  0.12928774 -1.2650612
# > [3,]  0.46091621 -1.26506123 -0.6868529
```
