"""
# Description

A logical node that represents a projection operation. It has two fields:

1. `source`: A relation that will be projected.
2. `expressions`: A tuple of `Expression` objects that define the projection.
"""
struct Projection{T, N} <: LogicalNode
    source::T
    expressions::NTuple{N, Expression}
end

function Base.print(io::IO, node::Projection)
    println(io, "Projection LogicalNode")
    # TODO: Print source here.
    for e in node.expressions
        println(io, e)
    end
end
