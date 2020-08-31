# TODO: Document this.
macro select(src, exprs...)
    Expr(
        :call,
        :Projection,
        esc(src),
        Expr(
            :tuple,
            expression_expr.(exprs)...,
        ),
    )
end
