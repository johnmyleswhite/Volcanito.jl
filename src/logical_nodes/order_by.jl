"""
# Description

A logical node that represents an order by operation. It has two fields:

1. `source`: A relation that will be ordered.
2. `transforms`: A tuple of `FunctionSpec` objects that define the ordering.
"""
struct OrderBy{T1, T2} <: LogicalNode
    source::T1
    transforms::T2
end

function Base.repr(io::IO, node::OrderBy)
    "An OrderBy node"
end
