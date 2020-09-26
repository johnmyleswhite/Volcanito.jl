
# TODO: Document this.
macro aggregate_vector(src, exprs...)
    Expr(
        :call,
        :AggregateVector,
        esc(src),
        Expr(
            :tuple,
            map(e -> expression_macro_call(e, __source__), exprs)...,
        ),
    )
end
