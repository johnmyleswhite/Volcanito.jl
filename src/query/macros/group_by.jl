# TODO: Document this.
macro group_by(src, exprs...)
    Expr(
        :call,
        :GroupBy,
        esc(src),
        Expr(
            :tuple,
            expression_expr.(exprs)...,
        ),
    )
end
