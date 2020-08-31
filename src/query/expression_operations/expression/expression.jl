"""
# Description

A type that contains the results of translating an expression into a form
that can be used to evaluate that expression as an anonymous function in any
of the supported forms.

# Examples

```
julia> Expression(
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
struct Expression{N, T1, T2}
    alias::Symbol
    body::Any
    raw_form::Any
    input_columns::NTuple{N, Symbol}
    column_index::Dict{Symbol, Int}
    tuple_form::T1
    broadcast_form::T2
    explicit_alias::Bool
    is_constant::Bool
    is_column::Bool
end

# TODO: Base.show
function Base.show(io::IO, x::Expression)
    @printf(
        """
        == Expression object ==

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

function Base.print(io::IO, x::Expression)
    print(io, String(Symbol(x.raw_form)))
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
function expression_expr(@nospecialize(e::Any))::Expr
    # TODO: Support passes as an argument.

    alias, body = get_alias(e)

    column_names = find_column_names(body)

    index = index_column_names(column_names)

    quote
        Expression(
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
macro expression(e::Any)
    expression_expr(e)
end
