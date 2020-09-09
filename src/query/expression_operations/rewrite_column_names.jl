"""
# Description

Rewrite an expression written in terms of column names (represented as symbols)
into an expression written in terms of indexing into a tuple using numeric
indices.

See docs/expression_rules.md for details.

# Arguments

1. `e::Any`: An expression.
2. `index::Dict{Symbol, Int}`: A dictionary mapping symbols to indices.

# Return Values

1. `e::Any`: An expression in which column name symbols are replaced by tuple
    indexing expressions.

# Examples

```
julia> rewrite_column_names(
           :(a + b),
           :t,
           Dict(:a => 1, :b => 2),
           true,
       )
:(t[1] + t[2])
```
"""
function rewrite_column_names(
    @nospecialize(e::Any),
    tuple_name::Any,
    index::Dict{Symbol, Int},
)
    if isa(e, Expr) && e.head == :(=)
        Expr(
            :(=),
            e.args[1],
            rewrite_column_names(e.args[2], tuple_name, index),
        )
    elseif isa(e, Expr) && e.head == :kw
        Expr(
            :kw,
            e.args[1],
            rewrite_column_names(e.args[2], tuple_name, index),
        )
    elseif isa(e, Expr) && e.head == :call
        rewritten_args = Any[]
        for i in 2:length(e.args)
            push!(
                rewritten_args,
                rewrite_column_names(e.args[i], tuple_name, index),
            )
        end
        Expr(
            :call,
            e.args[1],
            rewritten_args...,
        )
    elseif isa(e, Expr) && e.head == :$
        e
    elseif isa(e, Expr) && e.head == :comparison
        rewritten_args = Any[]
        for i in 1:length(e.args)
            if i % 2 == 1
                push!(
                    rewritten_args,
                    rewrite_column_names(e.args[i], tuple_name, index),
                )
            else
                push!(rewritten_args, e.args[i])
            end
        end
        Expr(e.head, rewritten_args..., )
    elseif isa(e, Expr) && e.head == :macrocall && isa(e.args[1], GlobalRef) && e.args[1].name == Symbol("@cmd")
        Expr(:ref, tuple_name, index[Symbol(e.args[3])])
    elseif isa(e, Expr)
        rewritten_args = Any[]
        for i in 1:length(e.args)
            push!(
                rewritten_args,
                rewrite_column_names(e.args[i], tuple_name, index),
            )
        end
        Expr(e.head, rewritten_args...,)
    elseif isa(e, Symbol)
        Expr(:ref, tuple_name, index[e])
    else
        e
    end
end

"""
# Description

Rewrite an expression written in terms of column names (represented as symbols)
into an expression written in terms of safe column names (symbols from gensym
calls).

See docs/expression_rules.md for details.

# Arguments

1. `e::Any`: An expression.
2. `mapping::Dict{Symbol, Symbol}`: A dictionary mapping symbols to symbols.

# Return Values

1. `e::Any`: An expression in which column name symbols are replaced by tuple
    indexing expressions.

# Examples

```
julia> rewrite_column_names_broadcast(
    :(a + b),
    Dict(:a => gensym(), :b => gensym()),
)
:(var"##256" + var"##257")
```
"""
function rewrite_column_names_broadcast(
    @nospecialize(e::Any),
    mapping::Dict{Symbol, Symbol},
)
    if isa(e, Expr) && e.head == :(=)
        Expr(
            :(=),
            e.args[1],
            rewrite_column_names_broadcast(e.args[2], mapping),
        )
    elseif isa(e, Expr) && e.head == :kw
        Expr(
            :kw,
            e.args[1],
            rewrite_column_names_broadcast(e.args[2], mapping),
        )
    elseif isa(e, Expr) && e.head == :call
        rewritten_args = Any[]
        for i in 2:length(e.args)
            push!(
                rewritten_args,
                rewrite_column_names_broadcast(e.args[i], mapping),
            )
        end
        Expr(
            :call,
            e.args[1],
            rewritten_args...,
        )
    elseif isa(e, Expr) && e.head == :$
        e
    elseif isa(e, Expr) && e.head == :comparison
        rewritten_args = Any[]
        for i in 1:length(e.args)
            if i % 2 == 1
                push!(
                    rewritten_args,
                    rewrite_column_names_broadcast(e.args[i], mapping),
                )
            else
                push!(rewritten_args, e.args[i])
            end
        end
        Expr(e.head, rewritten_args..., )
    elseif isa(e, Expr) && e.head == :macrocall && isa(e.args[1], GlobalRef) && e.args[1].name == Symbol("@cmd")
        mapping[Symbol(e.args[3])]
    elseif isa(e, Expr)
        rewritten_args = Any[]
        for i in 1:length(e.args)
            push!(
                rewritten_args,
                rewrite_column_names_broadcast(e.args[i], mapping),
            )
        end
        Expr(e.head, rewritten_args...,)
    elseif isa(e, Symbol)
        mapping[e]
    else
        e
    end
end
