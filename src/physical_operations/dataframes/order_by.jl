# TODO: Document this
function materialize(node::OrderBy)
    sorted_indices = sortperm(
        materialize(
            Projection(node.source, node.expressions)
        )
    )
    materialize(node.source)[sorted_indices, :]
end
