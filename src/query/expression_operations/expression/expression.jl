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
     t -> t[1] + t[2],
    (a, b) -> a + b,
    (a, b) -> a + b,
)
```
"""
struct Expression
    alias::Symbol
    body::Any
    raw_form::Any
    input_columns::Tuple
    tuple_form::Any
    broadcast_form::Any
    vector_form::Any
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
        tuple_form: %s
        broadcast_form: %s
        vector_form: %s""",
        x.alias,
        x.body,
        x.raw_form,
        x.input_columns,
        x.tuple_form,
        x.broadcast_form,
        x.vector_form,
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
function expression_expr(@nospecialize(e::Any))
    # TODO: Support passes as an argument.

    alias, body = get_alias(e)

    column_names = find_column_names(body)

    quote
        Expression(
            $(QuoteNode(alias)),
            $(QuoteNode(body)),
            $(QuoteNode(e)),
            $(column_names_tuple_expr(column_names)),
            $(tuple_form(body, column_names)),
            $(broadcast_form(body, column_names)),
            $(vector_form(body, column_names)),
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
