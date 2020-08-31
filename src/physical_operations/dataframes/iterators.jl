# TODO: Document this
function columns_tuple(
    src::DataFrames.DataFrame,
    names::NTuple{N, Symbol},
) where N
    tuple((src[name] for name in names)...)
end

# TODO: Document this
function tuple_iterator(
    src::DataFrames.DataFrame,
    names::NTuple{N, Symbol},
) where N
    zip(columns_tuple(src, names)...)
end

# TODO: Document this
function gen_column(src, f, column_names)
    map(f, tuple_iterator(src, column_names))
end

# TODO: Document this
function new_column(src, constant)
    [copy(constant) for _ in 1:size(src, 1)]
end

# TODO: Document this
function copy_column(src, column_name)
    copy(src[column_name])
end

# TODO: One wrapper fpr creating a column.
