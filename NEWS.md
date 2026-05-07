# News and Updates



### 2026, April 22nd

> Version 1.1.1.0001 released in public repository, first release.

### Bug fixes:
- `lindex()` now functions with tibbles for columnwise indexing.

### Major changes:
- `stripAttr()` now allows for specific attributes to be removed by passing attribute names as an argument. This behavior is forced to encourage mindful use by end users.

---

### 2026, April 25th:

> Version 1.1.1.0002 released in public repository.

### Major changes:
- Added NEWS file (I really should have added this earlier).
- Added README file with installation instructions, hints, and examples.

### Bug fixes:
- `lindex()` now performs recursive list indexing properly. Users can use a vector or list for recursive list indexing.

---

### 2026, May 7th:

> Version 1.1.2.0001 released in public repository.

### Major changes:
- Added new function `arrapply()` that allows for making shorthand nested calls to `base::sapply()` at arbitrarily high dimensions.
- `setDimnames()` now uses `...` arguments for the dimension names.
- `do()` has its functionality split between `do()` and `do0()`. The former takes an object `x` and a funcion `f` and returns `f(x)` while the latter takes only a no-argument function `f` and returns `f()`. This way, functionality is more explicit and `NULL` values of `x` can be meaningfully passed into `do()`, in case that is of interest to users.

### Minor improvements:
- `whichInv()` now accepts and automatically casts arguments to integer values.
