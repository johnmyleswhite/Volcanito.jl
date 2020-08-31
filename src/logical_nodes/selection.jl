"""
# Description

A logical node that represents a selection operation. It has two fields:

1. `source`: A relation that will be selected.
2. `predicate`: A single `Expression` object that defines the predictate.
"""
struct Selection{T} <: LogicalNode
    source::T
    predicate::Expression
end

function Base.print(io::IO, node::Selection)
    println(io, "Selection LogicalNode")
    # TODO: Print source here.
    for e in (node.predicate, )
        println(io, e)
    end
end
