# News and Updates



### 2026, August 12th:

> Version 1.1.2.0004 released in public repository.

### Major improvements:
- `arrapply()` now allows the output of `f` to be of arbitrary dimensions while still producing a predictably structured output.
- `arrapply()` performs compute-time validation of the outputs of `f` to ensure they are all of common dimensions.

---

### 2026, May 23rd:

> Version 1.1.2.0003 released in public repository.

### Major improvements:
- `arrapply()` now allows the output of `f` to be non-scalar.

---

### 2026, May 8th:

> Version 1.1.2.0002 released in public repository.

### Minor improvements:
- `setDimnames()` now allows either a list of character vectors or separate vectors under the `...` argument. This way, dimension names can easily be copied from one object to another.

---

### 2026, May 7th:

> Version 1.1.2.0001 released in public repository.

### Major changes:
- Added new function `arrapply()` that allows for making shorthand nested calls to `base::sapply()` at arbitrarily high dimensions.
- `setDimnames()` now uses `...` arguments for the dimension names.
- `do()` had its logic for running one-parameter and parameterless functions redone. Now, the number of arguments `f` has is used instead of checking if `x` is `NULL`. This should be more transparent to users.
- Added `roxygen2`-style documentation to all exported functions.

### Minor improvements:
- `whichInv()` now accepts and automatically casts arguments to integer values.

---

### 2026, April 25th:

> Version 1.1.1.0002 released in public repository.

### Major changes:
- Added NEWS file (I really should have added this earlier).
- Added README file with installation instructions, hints, and examples.

### Bug fixes:
- `lindex()` now performs recursive list indexing properly. Users can use a vector or list for recursive list indexing.

---

### 2026, April 22nd

> Version 1.1.1.0001 released in public repository, first release.

### Bug fixes:
- `lindex()` now functions with tibbles for columnwise indexing.

### Major changes:
- `stripAttr()` now allows for specific attributes to be removed by passing attribute names as an argument. This behavior is forced to encourage mindful use by end users.
