# Macros

Macro expansion roughly works as follows:

1. First, each expression is analyzed syntactically using a fixed set of
    [expression rules](https://github.com/johnmyleswhite/Volcanito.jl/blob/master/docs/expression_rules.md) to determine which symbols in
    the expression should be assumed to be columns in the table being processed.
2. Second, each expression is translated into a
    [Expression](expressions.md) object that represents the expression in
    several forms that can be used by different engines based on their internal
    data structures. The primary forms are:
    i. Raw form, which is simply the original quoted expression. An example
        is something like `:(a + b)`.
    ii. Tuple form, which translates an expression like `a + b` into the form
        `t -> t[1] + t[2]` along with an index of the form
        `Dict(:a => 1, :b => 2)`.
    iii. Broadcast form, which translates an expression like `a + b` into the
        form `(a, b) -> a + b`.
    During this expansion, several passes of expression rewriting are performed.
    These passes are documented in the [rewrite passes](rewrite_passes.md) doc.
3. Finally, these expressions are passed to basic constructor functions that
    engines should override.

The end result of this system is to take in input like,

```
@select(df, x = a + b)
```

and generate output like:

```
Projection(
    df,
    (
        Expression(
            :x,
            :(a + b),
            :(x = a + b),
            (:a, :b),
            Dict(:a => 1, :b => 2),
            t -> t[1] + t[2],
            (a, b) -> a + b,
            true,
            false,
            false,
        ),
    ),
)
```
