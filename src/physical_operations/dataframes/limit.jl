# TODO: Document this
function materialize(node::Limit)
    materialize(node.source)[1:node.n, :]
end
