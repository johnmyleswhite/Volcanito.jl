"""
# Description

A logical node that represents a projection operation. It has two fields:

1. `source`: A node describing a relation that will be projected.
2. `expressions`: A tuple of `Expression` objects that define the projection.
"""
struct Projection <: LogicalNode
    source::Any
    expressions::Tuple
end

function Base.print(io::IO, node::Projection)
    println(io, "Projection LogicalNode")
    println(io, type(node.source))
    for e in node.expressions
        println(io, e)
    end
end
