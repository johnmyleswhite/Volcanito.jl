# TODO: Document this
function materialize(node::Projection)
    out = DataFrames.DataFrame()
    for e in node.expressions
        out[e.alias] = generate_column(node.source, e)
    end
    out
end
