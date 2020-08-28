"""
# Description

A logical node that represents an aggregation that operates directly on vectors.
It has two fields:

1. `source`: A relation that is already divided into groups.
2. `aggregates`: A `Pair` object that can be passed to `DataFrames.combine`.
"""
struct AggregateVector{T1, T2} <: LogicalNode
    source::T1
    aggregates::T2
end

function Base.repr(io::IO, node::AggregateVector)
    "An AggregateVector node"
end
