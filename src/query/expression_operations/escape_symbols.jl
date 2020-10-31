"""
# Description

Rewrite an expression to escape all symbols except those in a specified ignore
list.

See docs/escaping.md for details.

# Arguments

1. `e::Any`: An expression.
2. `ignore::Tuple`: 

# Return Values

1. `e::Any`: 

# Examples

```
julia> escape_symbols(:(a + b), (:a, :b))
:(($(Expr(:escape, :+)))(a, b))
```
"""
function escape_symbols(
    @nospecialize(e::Any),
    ignore::Tuple=(:uses_default_lifting, ),
)::Any
    if isa(e, Expr)
        Expr(
            e.head,
            map(a -> escape_symbols(a, ignore), e.args)...,
        )
    elseif isa(e, Symbol)
        if e in ignore
            e
        else
            esc(e)
        end
    else
        e
    end
end
