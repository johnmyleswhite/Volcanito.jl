"""
# Description

A logical node that represents a limit operation. It has two fields:

1. `source`: A relation that will be limited.
2. `n`: The number of rows to limit to.
"""
struct Limit{T} <: LogicalNode
    source::T
    n::Int
end

function Base.print(io::IO, node::Limit)
    println(io, "Limit LogicalNode")
    # TODO: Print source here.
    println(io, node.n)
end
