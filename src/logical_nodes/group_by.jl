"""
# Description

A logical node that represents a group-by operation. It has two fields:

1. `source`: A node describing a relation that will be divided into groups.
2. `expressions`: A tuple of `Expression` objects that define the groups.
"""
struct GroupBy <: LogicalNode
    source::Any
    expressions::Tuple
end

function Base.print(io::IO, node::GroupBy)
    println(io, "GroupBy LogicalNode")
    println(io, type(node.source))
    for e in node.expressions
        println(io, e)
    end
end
