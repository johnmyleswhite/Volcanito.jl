"""
# Description

Only use `gensym` if there's a possible name collision with symbols in `e`.
There can't be a collision if the expression doesn't contain `:t` anywhere,
so this test is very simple.

# Arguments

1. `e::Any`: An expression.

# Return Values

1. `_::Bool`: `true` if the input object is a symbol; `false` otherwise.

# Examples

```
safe_tuple_name(:(a + b))
:($(Expr(:escape, :t)))
```
"""
function safe_tuple_name(e::Any)
    if inexpr(e, :t)
        tuple_name = gensym()
    else
        tuple_name = :t
    end
end
