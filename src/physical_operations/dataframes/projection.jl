# TODO: Document this
function materialize(op::Projection)
    out = DataFrames.DataFrame()
    for spec in op.transforms
        if spec.is_constant
            out[spec.alias] = new_column(
                materialize(op.source),
                spec.body,
            )
        elseif spec.is_column
            out[spec.alias] = copy_column(
                materialize(op.source),
                spec.body,
            )
        else
            out[spec.alias] = gen_column(
                materialize(op.source),
                spec.tuple_form,
                spec.input_columns,
            )
        end
    end
    out
end
