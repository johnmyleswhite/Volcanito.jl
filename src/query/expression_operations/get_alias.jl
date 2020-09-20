"""
# Description

Split apart an expression passed into one of the user-facing macros into two
parts:

1. An expression which defines a column (called the body), and
2. An expression which defines that column's name (called the alias).

This is typically the first expression-processing function called inside a
user-facing macro, so it does validation on the input code's body after
extracting the body to ensure that downstream functions will be able to operate
on the body without error.

* Given an expression, `e`, of the form `x = ex`, return a tuple
    `(x, ex)`.
* Given an expression, `e`, not of the form `x = ex`, return a tuple
    `(Symbol(e), e)`.

# Arguments

1. `e::Any`: An expression.

# Return Values

1. `alias::Symbol`: The alias of the newly generated column.
2. `body::Any`: The expression that defines the newly generated column.

# Examples

```
julia> get_alias(:x)
(:x, :x)

julia> get_alias(:(x = a + sin(b)))
(:x, :(a + sin(b)))
```
"""
function get_alias(@nospecialize(e::Any))::Tuple
    if isa(e, Expr) && e.head == :(=)
        alias, body = e.args[1], e.args[2]
    elseif isa(e, Expr) && e.head == :macrocall && isa(e.args[1], GlobalRef) && e.args[1].name == Symbol("@cmd")
        if startswith(e.args[3], '$')
            # TODO: Rethink this gensym()
            alias, body = gensym(), e
        else
            alias, body = Symbol(remove_backticks(Meta.parse(e.args[3]))), e
        end
    else
        alias, body = Symbol(remove_backticks(e)), e
    end

    validate(body)

    alias, body
end

# TODO: Document this.
has_alias(e::Any) = isa(e, Expr) && e.head == :(=)

# TODO: Document this.
function aliased(e)
    alias, body = get_alias(e)
    Expr(:(=), alias, body)
end
