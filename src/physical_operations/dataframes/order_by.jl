"""
Materialize an `OrderBy` into a `DataFrame` by computing the indices of the
sorted rows, then returning that.
"""
function materialize(node::OrderBy)
    sorted_indices = sortperm(
        materialize(
            Projection(node.source, node.expressions)
        )
    )
    materialize(node.source)[sorted_indices, :]
end
