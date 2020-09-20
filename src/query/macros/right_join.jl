macro right_join(src1, src2, exprs...)
    Expr(
        :call,
        :Join,
        Expr(
            :tuple,
            analyze_src_expr(src1),
            analyze_src_expr(src2),
        ),
        Expr(
            :tuple,
            expression_expr.(exprs)...,
        ),
        :(right::JoinKind),
    )
end
