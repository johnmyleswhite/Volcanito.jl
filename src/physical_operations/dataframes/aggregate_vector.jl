"""
Materialize an `AggregateVector` into a `DataFrame`. Currently only eager
materialization is allowed, which requires two steps:

1. Materialize the source node into a `DataFrame`.
2. Use `DataFrames.combine` to aggregate this `DataFrame`.
"""
function materialize(node::AggregateVector)
    DataFrames.combine(
        materialize(node.source),
        map(
            e -> [e.input_columns...] => e.vector_form => e.alias,
            node.aggregates,
        )...,
    )
end
