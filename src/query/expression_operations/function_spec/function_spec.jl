"""
# Description

A type that contains the results of translating an expression into a form
that can be used to evaluate that expression as an anonymous function in any
of the supported forms.

# Examples

```
julia> FunctionSpec(
    :x,
    :(a + b),
    :(x = a + b),
    (:a, :b),
    Dict(:a => 1, :b => 2),
    t -> t[1] + t[2],
    (a, b) -> a + b,
    false,
    false,
)
```
"""
struct FunctionSpec{T1, N, T2, T3, T4}
    alias::Symbol
    body::T1
    raw_form::T2
    input_columns::NTuple{N, Symbol}
    column_index::Dict{Symbol, Int}
    tuple_form::T3
    broadcast_form::T4
    explicit_alias::Bool
    is_constant::Bool
    is_column::Bool
end

# TODO: Base.show
function Base.show(io::IO, x::FunctionSpec)
    @printf(
        """
        == FunctionSpec object ==

        alias: %s
        body: %s
        raw_form: %s
        input_columns: %s
        column_index: %s
        tuple_form: %s
        broadcast_form: %s
        explicit_alias: %s
        is_constant: %s
        is_column: %s""",
        x.alias,
        x.body,
        x.raw_form,
        x.input_columns,
        x.column_index,
        x.tuple_form,
        x.broadcast_form,
        x.explicit_alias,
        x.is_constant,
        x.is_column,
    )
    nothing
end

# TODO: Base.repr

"""
# Description

...

# Arguments

1. ...

# Return Values

1. ...

# Examples

```
julia> 

```
"""
# TODO: Document this
function function_spec_expr(@nospecialize(e::Any))::Expr
    # TODO: Support passes as an argument.

    alias, body = get_alias(e)

    column_names = find_column_names(body)

    index = index_column_names(column_names)

    quote
        FunctionSpec(
            $(QuoteNode(alias)),
            $(QuoteNode(body)),
            $(QuoteNode(e)),
            $(as_expr(column_names)),
            $(as_expr(index)),
            $(esc(tuple_form(body, safe_tuple_name(body), index))),
            $(esc(broadcast_form(body, column_names))),
            $(has_alias(e)),
            $(is_constant(e)),
            $(is_column(e)),
        )
    end
end

"""
# Description

...

# Arguments

1. ...

# Return Values

1. ...

# Examples

```
julia> 

```
"""
# TODO: Document this
macro function_spec(e::Any)
    function_spec_expr(e)
end
