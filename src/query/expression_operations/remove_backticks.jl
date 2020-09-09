
"""
# Description

Rewrite an expression to remove all use of backticks.

# Arguments

1. `e::Any`: An expression.

# Return Values

1. `e::Any`: An expression in which backticks have been removed.

# Examples

```
julia> remove_backticks(:(`mean(a)`))
:(mean(a))
```
"""
function remove_backticks(@nospecialize(e::Any))
    if isa(e, Expr) && e.head == :macrocall && isa(e.args[1], GlobalRef) && e.args[1].name == Symbol("@cmd")
        Meta.parse(e.args[3])
    elseif isa(e, Expr)
        Expr(
            e.head,
            [remove_backticks(a) for a in e.args]...,
        )
    else
        e
    end
end
