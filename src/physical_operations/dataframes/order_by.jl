# TODO: Document this
function materialize(op::OrderBy)
    sorted_indices = sortperm(
        materialize(
            Projection(op.source, op.transforms)
        )
    )
    materialize(op.source)[sorted_indices, :]
end
