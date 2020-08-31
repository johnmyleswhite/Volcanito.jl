"""
# Description

A logical node that represents an order by operation. It has two fields:

1. `source`: A relation that will be ordered.
2. `expressions`: A tuple of `Expression` objects that define the ordering.
"""
struct OrderBy{T, N} <: LogicalNode
    source::T
    expressions::NTuple{N, Expression}
end

function Base.print(io::IO, node::OrderBy)
    println(io, "OrderBy LogicalNode")
    # TODO: Print source here.
    for e in node.expressions
        println(io, e)
    end
end
