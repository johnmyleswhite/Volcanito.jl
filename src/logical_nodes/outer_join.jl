"""
# Description

A logical node that represents an outer join operation. It has two fields:

1. `sources`: A tuple of two relations that will be joined.
2. `predicates`: A tuple of `Expression` objects that defines the predicates
    for the join.
"""
struct OuterJoin{T, N} <: LogicalNode
    sources::T
    predicates::NTuple{N, Expression}
end

function Base.print(io::IO, node::OuterJoin)
    println(io, "OuterJoin LogicalNode")
    # TODO: Print source here.
    for e in node.predicates
        println(io, e)
    end
end
