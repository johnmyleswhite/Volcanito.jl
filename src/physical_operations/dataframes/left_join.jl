# TODO: Document this
function materialize(node::LeftJoin)
    lhs, rhs = node.sources

    # TODO: Rewrite when we don't require equi-join on existing columns.
    pairs = map(p -> _predicate_to_pair(p, lhs, rhs), node.predicates)

    # TODO: Handle generating source table prefixes.
    DataFrames.leftjoin(
        materialize(lhs.source),
        materialize(rhs.source),
        on = [pairs...],
    )
end
