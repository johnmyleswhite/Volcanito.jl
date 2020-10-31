"""
# Description

Given an expression, `e`, convert it into an anonymous function over tuples. It
is assumed that `index` defines a mapping from symbols to indices that contains
an entry for every symbol that should be treated as a column name in `e`.

# Arguments

1. `e::Any`: An expression to be converted into an anonymous function
    expression.
2. `tuple_name::Any`: The local name of the tuple that the function will act
    upon. To maximize the readability of the resulting function, pass in a
    readable like `:t`. Use `safe_tuple_name` to find a name that is guaranteed
    to be safe to use.
3. `index::Dict{Symbol, Int}`: A mapping from column name symbosl to indices in
    the input tuple.
4. `passes::NamedTuple`: A specification of which rewrite passes should be
    performed on the input. There are three that can be activated:
    1. `locals`: A pass to unescape locals as in `a + \$b`.
    2. `lift`: A pass to lift all function calls. See docs/lifting.md for more
        details.
    3. `tvl`: A pass to rewrite all uses of `||` and `&&` to use three-valued
        logic.
    Currently `lift` is disabled as the functionality is not yet complete. The
    others are enabled by default, but can be turned off for easier debugging.

# Return Values

1. `e′::Any`: A new expression that defines an anonymous function in tuple
    form. See docs/forms.md for details.

# Examples

```
julia> tuple_form(:(a + b), :t, Dict(:a => 1, :b => 2))
:(t->begin
          #= REPL[21]:55 =#
          ($(Expr(:escape, :+)))(t[1], t[2])
      end)
```
"""
function tuple_form(
    @nospecialize(e::Any),
    column_names::NTuple{N, ColumnName},
    passes::NamedTuple = (locals=true, lift=false, tvl=true),
) where N
    tuple_name = safe_tuple_name(e)

    index = index_column_names(column_names)

    body = rewrite_column_names(e, tuple_name, index)

    if passes.locals
        body = unescape_locals(body)
    end

    if passes.lift
        body = lift_function_calls(body)
    end

    if passes.tvl
        body = tvl(body)
    end

    body = escape_symbols(body, (tuple_name, :uses_default_lifting))

    :($tuple_name -> $body)
end
