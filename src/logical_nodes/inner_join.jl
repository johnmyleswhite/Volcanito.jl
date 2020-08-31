"""
# Description

A logical node that represents an inner join operation. It has two fields:

1. `sources`: A tuple of two relations that will be joined.
2. `predicates`: A tuple of `Expression` objects that defines the predicates
    for the join.
"""
struct InnerJoin{T1, T2, N} <: LogicalNode
    sources::Tuple{T1, T2}
    predicates::NTuple{N, Expression}
end

function Base.print(io::IO, node::InnerJoin)
    println(io, "InnerJoin LogicalNode")
    # TODO: Print source here.
    for e in node.predicates
        println(io, e)
    end
end
