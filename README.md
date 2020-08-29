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
    * `InnerJoin`
    * `LeftJoin`
    * `RightJoin`
    * `OuterJoin`

* Define a basic implementation of how to carry out the logical plan in terms
    of primitive operations on DataFrames from
    [DataFrames.jl](https://github.com/JuliaData/DataFrames.jl).

For more details, see [docs/architecture.md](https://github.com/johnmyleswhite/Volcanito.jl/blob/master/docs/architecture.md).

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
