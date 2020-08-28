"""
# Description

A logical node that represents a selection operation. It has two fields:

1. `source`: A relation that will be selected.
2. `predicate`: A single `FunctionSpec` object that defines the predictate.
"""
struct Selection{T1, T2} <: LogicalNode
    source::T1
    predicate::T2
end

function Base.repr(io::IO, node::Selection)
    "A Selection node"
end
