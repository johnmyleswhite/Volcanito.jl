"""
Materialize a `Limit` into a `DataFrame`. Always select the first `n` rows.
"""
function materialize(node::Limit)
    materialize(node.source)[1:node.n, :]
end
