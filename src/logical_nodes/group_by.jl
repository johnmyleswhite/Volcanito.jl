"""
# Description

A logical node that represents a group-by operation. It has two fields:

1. `source`: A relation that will be divided into groups.
2. `expressions`: A tuple of `Expression` objects that define the groups that
    will be used downstream.
"""
struct GroupBy{T, N} <: LogicalNode
    source::T
    expressions::NTuple{N, Expression}
end

function Base.print(io::IO, node::GroupBy)
    println(io, "GroupBy LogicalNode")
    # TODO: Print source here.
    for e in node.expressions
        println(io, e)
    end
end
