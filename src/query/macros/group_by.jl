# TODO: Document this.
macro group_by(src, exprs...)
    Expr(
        :call,
        :GroupBy,
        esc(src),
        Expr(
            :tuple,
            function_spec_expr.(exprs)...,
        ),
    )
end
