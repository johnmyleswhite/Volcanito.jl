@enum JoinKind begin
    inner = 1
    left = 2
    right = 3
    outer = 4
end

"""
# Description

A logical node that represents an join operation. It has three fields:

1. `sources`: A tuple of two aliased relations that will be joined. Joins
    between more than two relations are represented as trees of binary joins.
2. `predicates`: A tuple of `Expression` objects that defines the predicates
    for the join.
3. `kind`: A enum value of type `JoinKind` indicating whether this is an inner,
    left, right or outer join.
"""
struct Join <: LogicalNode
    sources::Any
    predicates::Tuple
    kind::JoinKind
end

function Base.print(io::IO, node::Join)
    println(io, "Join LogicalNode")
    println(io, node.kind)
    println(io, type(node.source))
    for e in node.predicates
        println(io, e)
    end
end
