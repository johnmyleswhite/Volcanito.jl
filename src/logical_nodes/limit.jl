"""
# Description

A logical node that represents a limit operation. It has two fields:

1. `source`: A node describing a relation that will be limited.
2. `n`: The number of rows to limit to.
"""
struct Limit <: LogicalNode
    source::Any
    n::Int
end

function Base.print(io::IO, node::Limit)
    println(io, "Limit LogicalNode")
    println(io, type(node.source))
    println(io, node.n)
end
