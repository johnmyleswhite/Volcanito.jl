"""
# Description

A logical node that represents an aggregation that operates directly on vectors
rather than on a stream of scalars. It has two fields:

1. `source`: A relation to be aggregated.
2. `aggregates`: An aggregation definition. For DataFrames, this is currently
    a `Pair` object, but most other use cases would want a tuple of `Expression`
    objects. It is a limitation of the current implementation that the
    `@aggregate_vector` macro does not generate `Expression` objects.
"""
struct AggregateVector{T1, T2} <: LogicalNode
    source::T1
    # TODO: Find a way to avoid coupling this to DataFrames.combine.
    aggregates::T2
end

function Base.print(io::IO, node::AggregateVector)
    println(io, "AggregateVector LogicalNode")
    # TODO: Print source.
    # TODO: Print aggregates.
end
