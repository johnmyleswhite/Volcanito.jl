"""
# Description

Given a tuple of symbols, return a `Dict{Symbol, Int}`` mapping each symbol to
its index in the input tuple.

# Arguments

1. `column_names::NTuple{N, Symbol} where N`: A tuple of symbols.

# Return Values

1. `index::Dict{Symbol, Int}`: A dictionary mapping symbols to their indices in
  the input tuple.

# Examples

```
julia> index_column_names(((:a, false), (:b, false)))
Dict{ColumnName,Int64} with 2 entries:
  (:a, false) => 1
  (:b, false) => 2
```
"""
function index_column_names(column_names::NTuple{N, ColumnName}) where N
    Dict{ColumnName, Int}(column_names .=> 1:length(column_names))
end
