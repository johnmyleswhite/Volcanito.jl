"""
Materialize an `AggregateVector` node over a `DataFrame` by calling
`DataFrames.combine`.
"""
function materialize(node::AggregateVector)
    DataFrames.combine(
        node.aggregates,
        materialize(node.source),
    )
end
