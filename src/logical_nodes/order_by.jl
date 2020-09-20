"""
# Description

A logical node that represents an order by operation. It has two fields:

1. `source`: A node describing a relation that will be ordered.
2. `expressions`: A tuple of `Expression` objects that define the ordering.
"""
struct OrderBy <: LogicalNode
    source::Any
    expressions::Tuple
end

function Base.print(io::IO, node::OrderBy)
    println(io, "OrderBy LogicalNode")
    println(io, type(node.source))
    for e in node.expressions
        println(io, e)
    end
end
