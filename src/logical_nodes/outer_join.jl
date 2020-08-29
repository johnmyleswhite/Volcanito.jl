"""
# Description

A logical node that represents an outer join operation. It has two fields:

1. `source1`: A tuple of two relations that will be joined.
2. `predicates`: A tuple of `FunctionSpec` objects that defines the predicates
    for the join.
"""
struct OuterJoin{T1, T2} <: LogicalNode
    sources::T1
    predicates::T2
end

function Base.repr(io::IO, node::OuterJoin)
    "An OuterJoin node"
end
