function missing_check(es)
    if length(es) == 0
        false
    elseif length(es) == 1
        Expr(:call, :ismissing, es[1])
    elseif length(es) == 2
        Expr(
            :call,
            :(|),
            Expr(:call, :ismissing, es[1]),
            Expr(:call, :ismissing, es[2]),
        )
    elseif length(es) >= 3
        Expr(
            :call,
            :(|),
            Expr(:call, :ismissing, es[1]),
            missing_check(es[2:end])
        )
    end
end

# @test missing_check(()) === false
# @test missing_check((:x, )) == :(ismissing(x))
# @test missing_check((:x, :y)) == :(ismissing(x) | ismissing(y))
# @test missing_check((:x, :y, :z)) == :(ismissing(x) | (ismissing(y) | ismissing(z)))

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
        f = gensym()
        args = if length(e.args) >= 2
            e.args[2:end]
        else
            Any[]
        end
        temporaries = [gensym() for _ in args]

        create_temporaries_expr = Expr(
            :(=),
            Expr(:tuple, temporaries...),
            Expr(:tuple, args...),
        )
        missing_check_expr = missing_check(temporaries)
        f_call_temporaries = Expr(:call, f, temporaries...)
        f_call_raw = Expr(:call, f, args...)

        quote
            let $f = $(e.args[1])
                if uses_default_lifting($f)
                    $create_temporaries_expr
                    if $missing_check_expr
                        missing
                    else
                        $f_call_temporaries
                    end
                else
                    $f_call_raw
                end
            end
        end
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

# TODO: Add all Base functions with non-standard lifting as uses_default_lifting = false
# TODO: Reflect over methodswith(typeof(missing))
# Add all of these methods to the non-standard lifting list.
# for m in methodswith(typeof(missing))
#     uses_default_lifting(::typeof(m)) = false
# end

macro lift(e)
    lift_function_calls(e)
end

# foo(z::Int) = 42
# foo(missing)
# @lift foo(missing)

# @macroexpand @lift(sin(2))
# @macroexpand @lift(1 + 2)
# @macroexpand @lift(1 + sin(2))

# @lift(sin(2))
# @lift(1 + 2)
# @lift(1 + sin(2))
