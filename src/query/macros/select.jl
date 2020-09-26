# TODO: Document this.
macro select(src, exprs...)
    Expr(
        :call,
        :Projection,
        esc(src),
        Expr(
            :tuple,
            map(e -> expression_macro_call(e, __source__), exprs)...,
        ),
    )
end
