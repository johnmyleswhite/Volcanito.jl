# Expression Rules

Given an expression, we want to determine which symbols in the expression
should be assumed to be columns in the table being processed. We do this
purely syntactically to make it possible to use macros to do the work; as such,
we do not have access to any type information or even information about which
columns are in the table(s) being processed.

To address this, we employ the following rules that exclude symbols in certain
syntactic positions from being considered to refer to columns:

1. Anything on the LHS of an assignment expression like `:(x = y)` is
    excluded. In Julia, this is an `Expr` whose `head == :(=)`. This
    restriction reflects the assumption that columms cannot be assigned to
    while processing queries. This expression form also occurs in named tuple
    constructor expressions like `:(x = y, )`.
2. The LHS of a keyword argument expression is excluded. In Julia, this is an
    `Expr` whose head is `:kw`.
3. A plain symbol that is the first `args` to a function call expression is
    excluded. In Julia, this is an `Expr` whose `head == :call` and whose
    first `args` is a plain symbol. If the first is another expression, we
    scan the entire argument recursively.
4. Any arguments inside of a splicing/interpolation expression. In Julia, this
    is an `Expr` whose `head == :$`.
5. The even-numbered positional arguments to a `comparison` expression are
    excluded. In Julia, this is an `Expr` whose `head == :comparison`.
6. Any expression inside of backticks like `` `mean(col1)` `` is included.

Whenever processing expressions, please process them in the order described
above. It makes it easier to check completeness because you can treat the list
above as a checklist and it makes it easier to keep multiple functions in sync
because they can be compared without looking backwards.
