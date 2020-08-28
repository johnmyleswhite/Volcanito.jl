# TODO: Document this.
macro select(src, exprs...)
    Expr(
        :call,
        :Projection,
        esc(src),
        Expr(
            :tuple,
            function_spec_expr.(exprs)...,
        ),
    )
end
