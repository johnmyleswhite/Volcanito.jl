"""
Generate an output column by evaluating an `Expression` against `source`.
"""
function generate_column(source::Any, e::Expression)
    if is_constant(e.body)
        new_column(materialize(source), e.body)
    elseif is_column(e.body)
        # TODO: Make it possible to avoid copying here.
        copy_column(materialize(source), e.body)
    else
        gen_column(
            materialize(source),
            e.tuple_form,
            e.input_columns,
        )
    end
end
