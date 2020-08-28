"""
# Description

Determine if the input expression is solely the identifier of a column in a
table. Downstream systems can use this to avoid evaluating an anonymous
function by making a copy of the column instead.

# Arguments

1. `e::Any`: An expression.

# Return Values

1. `_::Bool`: `true` if the input object is a symbol; `false` otherwise.

# Examples

```
julia> is_column(:x)
true

julia> is_column(1)
false

julia> is_column(:(a + b))
false
```
"""
is_column(@nospecialize(e::Any)) = isa(e, Symbol)

"""
# Description

Determine if the input expression is solely a fixed constant. Downstream
systems can use this to avoid evaluating an anonymous function by making a new
column that contains many copies of that value instead.
    
# Arguments

1. `e::Any`: An expression.

# Return Values

1. `_::Bool`: `true` if the input object is a constant; `false` otherwise.

# Examples

```
julia> is_constant(:x)
false

julia> is_constant(1)
true

julia> is_constant(:(a + b))
false
```
"""
is_constant(@nospecialize(e::Any)) = !(isa(e, Symbol) || isa(e, Expr))
