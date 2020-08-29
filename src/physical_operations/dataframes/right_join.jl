# TODO: Document this
function materialize(op::RightJoin)
    lhs, rhs = op.sources

    # TODO: Rewrite when we don't require equi-join on existing columns.
    pairs = map(p -> _predicate_to_pair(p, lhs, rhs), op.predicates)

    # TODO: Handle generating source table prefixes.
    DataFrames.rightjoin(
        materialize(lhs.source),
        materialize(rhs.source),
        on = [pairs...],
    )
end
