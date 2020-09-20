# Volcanito.jl

Volcanito is an attempt to start standardizing the user-facing API that tables
expose in Julia. Because that task is too ambitious for one person writing code
in spurts every few months, the project is starting with something less
ambitious:

* Standardize on a set of user-facing macros that define primitive operations
    on tables:
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
* Lower those user-facing macros to objects that lazily represent those
    operations and can be used to build a simplified logical plan:
    * `Select`
    * `Where`
    * `GroupBy`
    * `AggregateVector`
    * `OrderBy`
    * `Limit`
    * `Join`

* Define a basic implementation of how to carry out the logical plan in terms
    of primitive operations on DataFrames from
    [DataFrames.jl](https://github.com/JuliaData/DataFrames.jl).

For more details, see [docs/architecture.md](https://github.com/johnmyleswhite/Volcanito.jl/blob/master/docs/architecture.md).

# Goals

Volcanito is a project that I started to explore a few areas in the Julia data
tools design space:

* *Laziness*: How much value can cross-operation optimizations provide if data
    tools have access to a full query plan created by lazy wrappers? How many
    optimization opportunities does the current eager evaluation strategy leave
    on the table?
* *Row-Wise Semantics*: Are there substantial challenges to using row-wise
    semantics everywhere even if DataFrames are stored as columns? Where is
    usability increased and where is it decreased by moving to a system in which
    all operations are described in terms of arbitrary Julia expressions over
    tuples?
* *Syntactical Optimizations* : How many opportunities for optimization depend
    upon having access to the source syntax of an expression? For example, can
    we support arbitrary join predicates, but use source syntax to optimize
    equijoins?
* *Generic Fallbacks*: How much of the data tooling can be handled generically
    in a way that new data formats can plug into trivially? Can we have generic
    definitions of nested for loop joins and hash joins that work on any source
    of tuples?

# Example Usage

```
import Pkg
Pkg.activate(".")

import DataFrames: DataFrame

import Statistics: mean

import Volcanito:
    @select,
    @where,
    @group_by,
    @aggregate_vector,
    @order_by,
    @limit,
    @inner_join

df = DataFrame(
    a = rand(10_000),
    b = rand(10_000),
    c = rand(Bool, 10_000),
)

@select(df, a, b, d = a + b)

@where(df, a > b)

@aggregate_vector(
    @group_by(df, !c),
    m_a = mean(a),
    m_b = mean(b),
    n_a = length(a),
    n_b = length(b),
)

@order_by(df, a + b)

@limit(df, 10)

@inner_join(
    a = df,
    b = @aggregate_vector(
        @group_by(df, c),
        m_a = mean(a),
        m_b = mean(b),
        n_a = length(a),
        n_b = length(b),
    ),
    a.c == b.c,
)

@aggregate_vector(df, m = mean(a))
```

To make it easier to understand how things work, the examples above all exploit
the fact that Volcanito's user-facing macros construct `LogicalNode` objects
that automatically materialize the result of a query whenever `Base.show` is
called. This makes it seem as if the user-facing macros operate eagerly, but
the truth is that they operate lazily and produce `LogicalNode` objects rather
than DataFrames. If you want to transform a `LogicalNode` object into a full
DataFrame, you should explicitly call `Volcanito.materialize`.

```
import Pkg
Pkg.activate(".")

import DataFrames: DataFrame

import Volcanito:
    @select,
    materialize

df = DataFrame(
    a = rand(10_000),
    b = rand(10_000),
    c = rand(Bool, 10_000),
)

plan = @select(df, a, b, d = a + b)

typeof(plan)

df = materialize(plan)

typeof(df)
```

# Expression Rewrites

To simplify working with data, the macros involve rewrite passes to automate
several tedious users otherwise do manually.

## Automatic Three-Valued Logic

Three-valued logic works even with short-circuiting Boolean operators:

```
import Pkg
Pkg.activate(".")

import DataFrames: DataFrame

import Volcanito: @where

df = DataFrame(
    a = [missing, 0.25, 0.5, 0.75],
    b = [missing, 0.75, 0.5, 0.25],
)

function f(x)
    println("Calling f(x) on x = $x")
    x + 1
end

@where(df, f(a) > 1.5 && f(b) >= 1.25)
```

## Local Variable Interpolation/Splicing

Local scalar variables can be interpolated/spliced into expressions:

```
import Pkg
Pkg.activate(".")

import DataFrames: DataFrame

import Volcanito: @where

df = DataFrame(
    a = [missing, 0.25, 0.5, 0.75],
    b = [missing, 0.75, 0.5, 0.25],
)

let x = 0.5
    @where(df, a >= $x)
end
```

## Backtick Syntax for Expressing Arbitrary Column Names

As in SQL, Volcanito allows backticks to be used to indicate that an otherwise
invalid identifier is a column name. This can be used when column names are
derived from an expression without an alias:

```
import Pkg
Pkg.activate(".")

import DataFrames: DataFrame

import Volcanito: @select, @aggregate_vector

import Statistics: mean

df = DataFrame(
    a = rand(10_000),
    b = rand(10_000),
)

@select(
    @aggregate_vector(df, mean(a)),
    `mean(a)` + 1,
)
```

This trick means that the normal Julia syntax for generating a `Cmd` object is
not available: use the `@cmd` macro instead to achieve the same effect.

## Backtick Syntax + Interpolation for Expressing Dynamic Column Names

One challenge with metaprogramming approaches like Volcanito employs is that it
can be difficult to use these techniques in functions in which the column names
to be computed aginst are not known statically. To address this, Volcanito
further coopts backtick syntax and combines it with interpolation syntax to make
it possible to indicate that column names are dynamic and only known at runtime.
An example of using this capacity in a function is shown below:

```
import Pkg
Pkg.activate(".")

import DataFrames: DataFrame

import Volcanito: @select, materialize

df = DataFrame(
    a = rand(10_000),
    b = rand(10_000),
)

function add_columns(df, x, y)
    @select(df, new_col = `$x` + `$y`)
end

add_columns(df, :a, :b)

isequal(
    materialize(@select(df, new_col = a + b)),
    materialize(add_columns(df, :a, :b)),
)
```
