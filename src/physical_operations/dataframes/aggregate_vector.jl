# TODO: Document this
function materialize(op::AggregateVector)
    DataFrames.combine(
        op.aggregates,
        materialize(op.source),
    )
end
