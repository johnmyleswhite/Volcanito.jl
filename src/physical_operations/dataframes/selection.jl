# TODO: Document this
function materialize(op::Selection)
    if op.predicate.is_constant
        # TODO: Only true, false or missing are valid.
        # TODO: Only true returns a meaningful result.
        mask = new_column(
            materialize(op.source),
            op.predicate.body,
        )
    elseif op.predicate.is_column
        # TODO: Only a Bool or Bool? column is valid here.
        mask = copy_column(
            materialize(op.source),
            op.predicate.body,
        )
    else
        mask = gen_column(
            materialize(op.source),
            op.predicate.tuple_form,
            op.predicate.input_columns,
        )
    end
    materialize(op.source)[coalesce.(mask, false), :]
end
