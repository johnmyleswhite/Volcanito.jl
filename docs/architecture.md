# Architecture

Volcanito provides an approach to working with tabular data in Julia that is
based on a three-part architecture described by the following sequence diagram:

> Query Macros => Logical Nodes => Physical Operations

# Part 1: Queries Expressed Using User-Facing Macros

End users of Volcanito are intended to think about working with data in terms
of requesting that certain primitive operations be performed on tables. These
macros are:

* `@select`
* `@where`
* `@group_by`
* `@aggregate_vector`
* `@order_by`
* `@limit`
* `@inner_join`
* `@left_join`
* `@right_join`
* `@outer_join`

Each of these macros, except for `@aggregate_vector`, is meant to be thought of
as if users were evaluating expressions against rows in the table in a system in
which the fields in the row were bound to local variables. Thus a macro call
like,

```
@select(df, c = a + b + rand())
```

should be thought of as evaluating the expression `a + b + rand()` once per
row and generating a new variable `c` as a result.

# Part 2: Logical Nodes to Build Up Query Plans

Each of the user-facing macros translates into a logical node that is a lazy
representation of the operation the user has requested, but these operations
are not carried out by default. (To improve interactive usage, `Base.show` is
defined for all logical nodes in terms of implicit materialization, so the
results of operations are displayed immediately in the REPL or in notebooks.
This materialization does not happen otherwise and must be requested
explicitly.)

Each node consists of one or more sources and then the expressions that need
to be computed to carry out the node's core operation.

Each expression is described in terms of a `FunctionSpec` object, which is a
backend-agnostic representation of the expressions passed to the user-facing
macros. Each `FunctionSpec` contains several fields described in
[docs/function_specs.md](https://github.com/johnmyleswhite/Volcanito.jl/blob/master/docs/function_specs.md).

# Part 3: Physical Operations

Volcanito derives its names from the
[Volcano model](https://paperhub.s3.amazonaws.com/dace52a42c07f7f8348b08dc2b186061.pdf)
in which physical operations take place using tuple iterators.

To demonstrate the viability of that approach for tables in Julia, Volcanito
uses tuple iterators to provide default physical operations that work on
DataFrames from the [DataFrames.jl](https://github.com/JuliaData/DataFrames.jl)
package.
