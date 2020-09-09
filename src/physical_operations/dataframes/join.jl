"""
Materialize a `Join` into a `DataFrame`. Currently only eager
materialization is allowed, which requires two steps:

1. Materialize the LHS and RHS source nodes into `DataFrame` objects.
2. Use `DataFrames.innerjoin` (or similar) to generate the `DataFrame` output
    based on the LHS and RHS inputs.
"""
function materialize(node::Join)
    lhs, rhs = node.sources

    # TODO: Rewrite when we don't require equi-join on existing columns.
    pairs = map(p -> _predicate_to_pair(p, lhs, rhs), node.predicates)

    # TODO: Handle generating source table prefixes.
    if node.kind === inner::JoinKind
        DataFrames.innerjoin(
            materialize(lhs.source),
            materialize(rhs.source),
            on = [pairs...],
        )
    elseif node.kind === left::JoinKind
        DataFrames.leftjoin(
            materialize(lhs.source),
            materialize(rhs.source),
            on = [pairs...],
        )
    elseif node.kind === right::JoinKind
        DataFrames.rightjoin(
            materialize(lhs.source),
            materialize(rhs.source),
            on = [pairs...],
        )
    elseif node.kind === outer::JoinKind
        DataFrames.outerjoin(
            materialize(lhs.source),
            materialize(rhs.source),
            on = [pairs...],
        )
    end
end
