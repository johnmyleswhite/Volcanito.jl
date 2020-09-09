# TODO: Document this.
macro aggregate_vector(src, exprs...)
    Expr(
        :call,
        :AggregateVector,
        esc(src),
        Expr(
            :tuple,
            expression_expr.(exprs)...,
        ),
    )
end
