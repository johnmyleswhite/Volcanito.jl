# TODO: Document this
macro aggregate_vector(src, exprs...)
    all_column_names = Set{Symbol}()

    for expr in exprs
        @assert has_alias(expr)
        alias, body = get_alias(expr)
        push!(all_column_names, find_column_names(body)...)
    end

    all_columns_vec_expr = Expr(
        :vect,
        map(s -> QuoteNode(s), (all_column_names..., ))...,
    )

    all_columns_tuple_expr = Expr(
        :tuple,
        map(s -> esc(s), (all_column_names..., ))...,
    )

    aggregates_tuple_expr = Expr(
        :tuple,
        map(e -> esc(e), exprs)...,
    )

    quote
        AggregateVector(
            $(esc(src)),
            $all_columns_vec_expr =>
                $all_columns_tuple_expr ->
                    $aggregates_tuple_expr,
        )
    end
end
