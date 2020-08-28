# TODO: Document this.
macro where(src, exprs...)
    for expr in exprs
        # TODO: Add proper error messages here.
        @assert !has_alias(expr)
    end

    e = fuse_conjunction(exprs)

    Expr(
        :call,
        :Selection,
        esc(src),
        function_spec_expr(e),
    )
end
