"""
# Description

Convert a value `x`, into an expression that evaluates to that value. Useful
for taking a value constructed during macro evaluation and placing it in the
resulting output expression. Only handles a limited set of types.

# Arguments

1. `x::Any`: A value to be converted into an expression.

# Return Values

1. `e′::Any`: An expression that evaluates to `x`.

# Examples

```
julia> as_expr(Dict(:a => 1, :b => 2))
:(Dict{Symbol, Int}(:a => 1, :b => 2))
```
"""
function as_expr(@nospecialize(x))::Any
    if isa(x, NTuple{N, Symbol} where N)
        Expr(
            :tuple,
            map(as_expr, x)...,
        )
    elseif isa(x, Dict{Symbol, Int})
        args = Expr[]
        for (k, v) in x
            push!(
                args,
                Expr(
                    :call,
                    :(=>),
                    as_expr(k),
                    as_expr(v),
                ),
            )
        end
        Expr(
            :call,
            :(Dict{Symbol, Int}),
            args...,
        )
    elseif isa(x, Symbol)
        QuoteNode(x)
    elseif isa(x, Int)
        x
    else
        error("Input type cannot be converted by as_expr")
    end
end
