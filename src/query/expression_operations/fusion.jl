"""
# Description

Given a tuple of expressions that evaluated to `Bool`, fuse them into a
single expression that computes their conjunction. Return `nothing` if the
input tuple is empty.

# Arguments

1. `bodies::Tuple`: A tuple of expressions. Each is assumed to evaluate
    to a `Bool` value.

# Return Values

1. `e::Union{Nothing, Expr}`: An expression containing the conjunction of
    the input expressions. `nothing` is returned if `isempty(bodies)`.

# Examples

```
julia> fuse_conjunction((:(a > 0), :(b < 1)))
:(a > 0 && b < 1)
```
"""
function fuse_conjunction(bodies::Tuple)
    if isempty(bodies)
        nothing
    else
        foldl((l, r) -> Expr(:&&, l, r), bodies)
    end
end
