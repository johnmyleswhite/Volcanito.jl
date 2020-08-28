"""
# Description

A logical node that represents a projection operation. It has two fields:

1. `source`: A relation that will be projected.
2. `transforms`: A tuple of `FunctionSpec` objects that define the projection.
"""
struct Projection{T1, T2} <: LogicalNode
    source::T1
    transforms::T2
end

function Base.repr(io::IO, node::Projection)
    "A Projection node"
end
