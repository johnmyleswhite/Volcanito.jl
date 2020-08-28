"""
# Description

Rewrite a pair of expressions, `x` and `y`, into a single expression in which
both are the operands of `x || y` in a world in which `||` uses three-valued
logic.

# Arguments

1. `x::Any`: An expression.
2. `y::Any`: An expression.

# Return Values

1. `e′::Any`: A new expression that computes the three-valued logic value of
    `x || y` with proper short-circuiting.

# Examples

```
julia> tvl_or(:a, :b)
quote
    #= REPL[1]:28 =#
    let var"##254" = a
        #= REPL[1]:29 =#
        if var"##254" === true
            #= REPL[1]:30 =#
            true
        elseif #= REPL[1]:31 =# var"##254" === false
            #= REPL[1]:32 =#
            b
        else
            #= REPL[1]:34 =#
            if b === true
                #= REPL[1]:35 =#
                true
            else
                #= REPL[1]:37 =#
                missing
            end
        end
    end
end
```
"""
function tvl_or(@nospecialize(x::Any), @nospecialize(y::Any))
    t1 = gensym()
    quote
        let $t1 = $x
            if $t1 === true
                true
            elseif $t1 === false
                $y
            else
                if $y === true
                    true
                else
                    missing
                end
            end
        end
    end
end

"""
# Description

Rewrite a pair of expressions, `x` and `y`, into a single expression in which
both are the operands of `x && y` in a world in which `&&` uses three-valued
logic.

# Arguments

1. `x::Any`: An expression.
2. `y::Any`: An expression.

# Return Values

1. `e′::Any`: A new expression that computes the three-valued logic value of
    `x && y` with proper short-circuiting.

# Examples

```
julia> tvl_and(:a, :b)
quote
    #= REPL[4]:4 =#
    let var"##255" = a
        #= REPL[4]:5 =#
        if var"##255" === false
            #= REPL[4]:6 =#
            false
        elseif #= REPL[4]:7 =# var"##255" === true
            #= REPL[4]:8 =#
            b
        else
            #= REPL[4]:10 =#
            if b === false
                #= REPL[4]:11 =#
                false
            else
                #= REPL[4]:13 =#
                missing
            end
        end
    end
end
```
"""
function tvl_and(@nospecialize(x), @nospecialize(y))
    t1 = gensym()
    quote
        let $t1 = $x
            if $t1 === false
                false
            elseif $t1 === true
                $y
            else
                if $y === false
                    false
                else
                    missing
                end
            end
        end
    end
end

"""
# Description

Rewrite an arbitary expression, `e`, to use TVL at its top-level without
recursively descending into its components.

# Arguments

1. `e::Any`: An expression.

# Return Values

1. `e′::Any`: A new expression in which `||` or `&&` are replaced with their
    three-valued logic counterparts.

# Examples

```
julia> rewrite_tvl(:(a || b))
quote
    #= REPL[1]:28 =#
    let var"##256" = a
        #= REPL[1]:29 =#
        if var"##256" === true
            #= REPL[1]:30 =#
            true
        elseif #= REPL[1]:31 =# var"##256" === false
            #= REPL[1]:32 =#
            b
        else
            #= REPL[1]:34 =#
            if b === true
                #= REPL[1]:35 =#
                true
            else
                #= REPL[1]:37 =#
                missing
            end
        end
    end
end
```
"""
function rewrite_tvl(@nospecialize(e::Any))
    if isa(e, Expr) && e.head == :||
        tvl_or(e.args[1], e.args[2])
    elseif isa(e, Expr) && e.head == :&&
        tvl_and(e.args[1], e.args[2])
    else
        e
    end
end

"""
# Description

Recursively rewrite an arbitary expression, `e`, to use TVL.

# Arguments

1. `e::Any`: An expression.

# Return Values

1. `e′::Any`: A new expression in which three-valued logic has been substituted
    throughout the entire expression tree.

# Examples

```
julia> tvl(:(a || b))
quote
    #= REPL[1]:28 =#
    let var"##259" = a
        #= REPL[1]:29 =#
        if var"##259" === true
            #= REPL[1]:30 =#
            true
        elseif #= REPL[1]:31 =# var"##259" === false
            #= REPL[1]:32 =#
            b
        else
            #= REPL[1]:34 =#
            if b === true
                #= REPL[1]:35 =#
                true
            else
                #= REPL[1]:37 =#
                missing
            end
        end
    end
end
```
"""
function tvl(@nospecialize(e::Any))
    postwalk(rewrite_tvl, e)
end

"""
# Description

A macro that rewrites the input to use three-valued logic.

# Arguments

1. `e::Any`: An expression.

# Return Values

1. `e′::Any`: A new expression in which three-valued logic is used.

# Examples

```
julia> @tvl(false || missing)
missing

julia> @tvl(true || missing)
true
```
"""
macro tvl(e)
    esc(tvl(e))
end
