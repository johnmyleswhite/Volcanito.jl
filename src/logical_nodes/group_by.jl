"""
# Description

A logical node that represents a group by operation. It has two fields:

1. `source`: A relation that will be divided into groups.
2. `transforms`: A tuple of `FunctionSpec` objects that define the groups that
    will be used downstream.
"""
struct GroupBy{T1, T2} <: LogicalNode
    source::T1
    transforms::T2
end

function Base.repr(io::IO, node::GroupBy)
    "A GroupBy node"
end
