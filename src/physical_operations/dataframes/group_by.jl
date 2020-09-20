"""
Materialize a `GroupBy` into a `GroupedDataFrame`. Currently only eager
materialization is allowed, which requires two steps:

1. Materialize the source node into a `DataFrame`, then make a shallow copy of
    it that shares columns with `materialize(node.source)`.
2. Use `DataFrames.groupby` to generate the `GroupedDataFrame`.
"""
function materialize(node::GroupBy)
    # TODO: Performance optimization opportunity:
    #     Don't make a copy if all group keys are existing columns.
    tmp = copy(materialize(node.source), copycols=false)
    # TODO: Handle possible conflicts with existing columns here.
    for e in node.expressions
        tmp[e.alias] = generate_column(node.source, e)
    end
    DataFrames.groupby(tmp, [e.alias for e in node.expressions])
end
