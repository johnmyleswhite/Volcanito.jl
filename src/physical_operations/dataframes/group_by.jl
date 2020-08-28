# TODO: Document this
function materialize(op::GroupBy)
    tmp = copy(materialize(op.source), copycols=false)
    # TODO: Handle possible conflicts here.
    for spec in op.transforms
        if spec.is_constant
            tmp[spec.alias] = new_column(materialize(op.source), spec.body)
        elseif spec.is_column
            tmp[spec.alias] = copy_column(materialize(op.source), spec.body)
        else
            tmp[spec.alias] = gen_column(
                tmp,
                spec.tuple_form,
                spec.input_columns,
            )
        end
    end
    DataFrames.groupby(tmp, vcat([s.alias for s in op.transforms]...))
end
