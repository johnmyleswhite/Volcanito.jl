"""
# Description

Given an expression, `e`, and `Set{ColumnName}`, `column_names`, this
function will recursively descend the expression adding any symbols to
`column_names` that should be considered column names based on their syntactic
position in the expression. The Boolean flag is `true` if the symbol is a
dynamic name rather than a static name.

See docs/expression_rules.md for a high-level description of the logic of how
potential column names are meant to be identified.

# Arguments

1. `e::Any`: An expression.
2. `column_names::Set{ColumnName}`: A set of symbols that will be
    mutated to contain all column names found in `e`.

# Return Values

1. `column_names::Set{ColumnName}`: The input `column_names`, which
    has been mutated to contain the column names.

# Examples

```
julia>  _find_column_names!(:(a + sin(b)), Set{ColumnName}())
```
"""
function _find_column_names!(
    @nospecialize(e::Any),
    column_names::Set{ColumnName},
)::Nothing
    if isa(e, Expr) && e.head == :(=)
        for i in 2:length(e.args)
            _find_column_names!(e.args[i], column_names)
        end
        nothing
    elseif isa(e, Expr) && e.head == :kw
        _find_column_names!(e.args[2], column_names)
        nothing
    elseif isa(e, Expr) && e.head == :call
        j = isa(e.args[1], Symbol) ? 2 : 1
        for i in j:length(e.args)
            _find_column_names!(e.args[i], column_names)
        end
        nothing
    elseif isa(e, Expr) && e.head == :$
        nothing
    elseif isa(e, Expr) && e.head == :comparison
        for i in 1:length(e.args)
            if i % 2 == 1
                _find_column_names!(e.args[i], column_names)
            end
        end
        nothing
    elseif isa(e, Expr) && e.head == :macrocall && isa(e.args[1], GlobalRef) && e.args[1].name == Symbol("@cmd")
        if startswith(e.args[3], '$')
            push!(column_names, ColumnName(Symbol(strip(e.args[3], '$')), true))
        else
            push!(column_names, ColumnName(Symbol(e.args[3]), false))
        end
        nothing
    elseif isa(e, Expr)
        for i in 1:length(e.args)
            _find_column_names!(e.args[i], column_names)
        end
        nothing
    elseif isa(e, Symbol)
        push!(column_names, ColumnName(e, false))
        nothing
    else
        nothing
    end
end

"""
# Description

Find all column names occuring in an expression, `e`, and return them as a
tuple of symbols.

# Arguments

1. `e::Any`: An expression.

# Return Values

1. `column_names::NTuple{N, ColumnName} where N`: A tuple containing
    all column names found in `e` and a flag indicating whether they are
    static or dynamic names.

# Examples
```
julia> find_column_names(:(a + b + sin(c) + `\$d`))
((:a, false), (:d, true), (:c, false), (:b, false))
```
"""
function find_column_names(@nospecialize(e::Any))::Tuple
    column_names = Set{ColumnName}()
    _find_column_names!(e, column_names)
    (column_names..., )
end
