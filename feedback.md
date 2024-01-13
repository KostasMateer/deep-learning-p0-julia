**Score: 10 / 10**

* Great summaries of code-review updates.
  - Though avoiding push! is the right approach!

## matrices.jl
* Some of the in-line comments are excessive.
  - For example: "creates a vector of the size" or "finding the sum of the array"

## gradients.jl
* The use of a temp variable is appropriate, but it helps to give it a better name.
  - I would call the line 27 temp something like "term_val"
  - And the one on line 48 could be "term_deriv"