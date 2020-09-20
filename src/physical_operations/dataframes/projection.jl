"""
Materialize a `Projection` into a `DataFrame` by generating each output column
in sequence.
"""
function materialize(node::Projection)
    out = DataFrames.DataFrame()
    # TODO: Perfomanance optimization
    #    If there are no cross-dependencies, generate the output in parallel.
    for e in node.expressions
        out[e.alias] = generate_column(node.source, e)
    end
    out
end
