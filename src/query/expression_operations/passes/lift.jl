"""
# Description

Given an expression, if the code is a function call expression, rewrite the
call to perform automatic lifting. See docs/lifting.md for details.

Any input that is not a function call is returned as is.

# Arguments

1. `e::Any`: An expression.

# Return Values

1. `_::Any`: A new expression in which lifting has been performed.

# Examples

```
julia> ...
```
"""
function lift_function_call(@nospecialize(e::Any))
    if isa(e, Expr) && e.head == :call
        e
        # TODO: Generate something like the following
        # if uses_default_lifting(foo)
        #     tmp1 = x
        #     if ismissing(tmp1)
        #         missing
        #     else
        #         f(tmp1)
        #     end
        # else
        #     f′ = lift(f)
        #     f′(args...)
        # end
    else
        e
    end
end

"""
# Description

Recursively descend an expression lifting all function calls.

# Arguments

1. `e::Any`: An expression.

# Return Values

1. `_::Any`: A new expression in which lifted has been performed.

# Examples

```
julia> ...
```

"""
function lift_function_calls(@nospecialize(e::Any))
    postwalk(lift_function_call, e)
end


"""
# Description

This is a generic function that specific functions can override to indicate
that they handle `missing` in a special way.

# Arguments

1. `f::Any`: A function-like object.

# Return Values

1. `_::Bool`: Does that function use the default lifting strategy outlined in
docs/lifting.md? If so, return `true`; else, return `false`.


# Examples

```
julia> uses_default_lifting(sin)
true
```
"""
uses_default_lifting(f::Any) = true

# TODO: Define lift(f:Any) = f
# TODO: Add all Base functions with non-standard lifting
# TODO: Reflect over methodswith(typeof(missing))
# Add all of these methods to the non-standard lifting list.
# for m in methodswith(typeof(missing))
#     uses_default_lifting(::typeof(m)) = false
#     lift(::typeof(m)) = m
# end
