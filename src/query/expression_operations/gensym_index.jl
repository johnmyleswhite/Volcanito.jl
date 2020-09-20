function gensym_index(column_names::NTuple{N, ColumnName}) where N
    safe_column_names = ntuple(i -> gensym(), length(column_names))
    mapping = Dict{ColumnName, Symbol}(column_names .=> safe_column_names)
    safe_column_names, mapping
end
