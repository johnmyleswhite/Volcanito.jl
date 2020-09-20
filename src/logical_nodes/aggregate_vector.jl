"""
# Description

A logical node that represents an aggregation that operates directly on vectors
rather than on a stream of scalars. It has two fields:

1. `source`: A node describing an immediate relation to be aggregated or a
    `GroupBy` node.
2. `aggregates`: A tuple of `Expression` objects representing aggregations.
"""
struct AggregateVector <: LogicalNode
    source::Any
    aggregates::Tuple
end

function Base.print(io::IO, node::AggregateVector)
    println(io, "AggregateVector LogicalNode")
    println(io, type(node.source))
    for e in node.aggregates
        println(io, e)
    end
end
