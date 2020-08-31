# TODO: Document this
function materialize(node::GroupBy)
    # TODO: Don't make a copy if all group keys are columns
    tmp = copy(materialize(node.source), copycols=false)
    # TODO: Handle possible conflicts here.
    for e in node.expressions
        tmp[e.alias] = generate_column(node.source, e)
    end
    DataFrames.groupby(tmp, vcat([e.alias for e in node.expressions]...))
end
