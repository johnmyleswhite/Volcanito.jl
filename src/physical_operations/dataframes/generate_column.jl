# TODO: Make it possible to avoid copying.
# TODO: Document this.
function generate_column(source::Any, e::Expression)
    if e.is_constant
        new_column(materialize(source), e.body)
    elseif e.is_column
        copy_column(materialize(source), e.body)
    else
        gen_column(
            materialize(source),
            e.tuple_form,
            e.input_columns,
        )
    end
end
