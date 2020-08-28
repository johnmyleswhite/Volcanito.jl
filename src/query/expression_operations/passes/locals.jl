"""
# Description

Walk down an expression recursively while rewriting interpolation expressions
into the interpolated symbol.

# Arguments

1. `e::Any`: An expression.

# Return Values

1. `_::Any`: A new expression in which all splicing has been removed.

# Examples

```
julia> unescape_locals(Expr(:call, :+, :a, Expr(:\$, :b)))
:(a + $(Expr(:escape, :b)))
```
"""
function unescape_locals(@nospecialize(e::Any))
    if isa(e, Expr) && e.head == :$
        # TODO: Reject if e.args[1] is not a symbol?
        # If doing this, do it in validate.
        e.args[1]
    elseif isa(e, Expr)
        Expr(e.head, unescape_locals.(e.args)...)
    else
        e
    end
end
