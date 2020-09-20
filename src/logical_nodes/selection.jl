"""
# Description

A logical node that represents a selection operation. It has two fields:

1. `source`: A node describing a relation that will be selected.
2. `predicate`: A single `Expression` object that defines the predictate.
"""
struct Selection <: LogicalNode
    source::Any
    predicate::Expression
end

function Base.print(io::IO, node::Selection)
    println(io, "Selection LogicalNode")
    println(io, type(node.source))
    for e in (node.predicate, )
        println(io, e)
    end
end
