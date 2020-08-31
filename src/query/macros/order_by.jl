# TODO: Document this.
macro order_by(src, exprs...)
    for expr in exprs
        # TODO: Add proper error messages here.
        @assert !has_alias(expr)
    end

    Expr(
        :call,
        :OrderBy,
        esc(src),
        Expr(
            :tuple,
            expression_expr.(exprs)...,
        ),
    )
end
