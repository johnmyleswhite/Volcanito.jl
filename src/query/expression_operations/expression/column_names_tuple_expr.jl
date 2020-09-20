"""
# Description

Convert a value `x`, into an expression that evaluates to that value. Useful
for taking a value constructed during macro evaluation and placing it in the
resulting output expression. Only handles a very limited set of types needed
to construct `Expression` objects.

# Arguments

1. `x::Any`: A value to be converted into an expression.

# Return Values

1. `e′::Any`: An expression that evaluates to `x`.

# Examples

```
julia> column_names_tuple_expr((ColumnName(:a, false), ColumnName(:b, true)))
:((:a, $(Expr(:escape, :b))))
```
"""
function column_names_tuple_expr(@nospecialize(x::Any))
    if isa(x, NTuple{N, ColumnName} where N)
        Expr(
            :tuple,
            map(column_names_tuple_expr, x)...,
        )
    elseif isa(x, ColumnName)
        if x.is_dynamic === false
            QuoteNode(x.name)
        else
            esc(x.name)
        end
    else
        error("Input type cannot be converted by column_names_tuple_expr")
    end
end
