abstract type LogicalNode
end

Base.show(io::IO, node::LogicalNode) = Base.show(materialize(node))
