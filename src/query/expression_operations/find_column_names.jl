"""
# Description

Given an expression, `e`, and a set of symbols, `column_names`, this function
will recursively descend the expression adding any symbols to `column_names`
that should be considered column names based on their syntactic position in the
expression.

See docs/expression_rules.md for a high-level description of the logic of how
potential column names are meant to be identified.

# Arguments

1. `e::Any`: An expression.
2. `column_names::Set{Symbol}`: A set of symbols that will be mutated to
    contain all column names found in `e`.

# Return Values

1. `column_names::Set{Symbol}`: The input `column_names`, which has been
    mutated to contain the column names.

# Examples

```
julia> _find_column_names!(:(a + sin(b)), Set{Symbol}())
Set{Symbol} with 2 elements:
  :a
  :b
```
"""
function _find_column_names!(
    @nospecialize(e::Any),
    column_names::Set{Symbol},
)::Set{Symbol}
    if isa(e, Expr) && e.head == :(=)
        for i in 2:length(e.args)
            _find_column_names!(e.args[i], column_names)
        end
        column_names
    elseif isa(e, Expr) && e.head == :kw
        _find_column_names!(e.args[2], column_names)
        column_names
    elseif isa(e, Expr) && e.head == :call
        j = isa(e.args[1], Symbol) ? 2 : 1
        for i in j:length(e.args)
            _find_column_names!(e.args[i], column_names)
        end
        column_names
    elseif isa(e, Expr) && e.head == :$
        column_names
    elseif isa(e, Expr) && e.head == :comparison
        for i in 1:length(e.args)
            if i % 2 == 1
                _find_column_names!(e.args[i], column_names)
            end
        end
        column_names
    elseif isa(e, Expr) && e.head == :macrocall && isa(e.args[1], GlobalRef) && e.args[1].name == Symbol("@cmd")
        push!(column_names, Symbol(e.args[3]))
    elseif isa(e, Expr)
        for i in 1:length(e.args)
            _find_column_names!(e.args[i], column_names)
        end
        column_names
    elseif isa(e, Symbol)
        push!(column_names, e)
        column_names
    else
        column_names
    end
end

"""
# Description

Find all column names occuring in an expression, `e`, and return them as a
tuple of symbols.

# Arguments

1. `e::Any`: An expression.

# Return Values

1. `column_names::NTuple{N, Symbol} where N`: A tuple containing all column
    names found in `e`.

# Examples
```
julia> find_column_names(:(a + b + sin(c)))
(:a, :b, :c)
```
"""
function find_column_names(@nospecialize(e::Any))::Tuple
    column_names = Set{Symbol}()
    _find_column_names!(e, column_names)
    (column_names..., )
end
