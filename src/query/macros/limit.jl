# TODO: Document this.
macro limit(src, n)
    Expr(
        :call,
        :Limit,
        esc(src),
        n,
    )
end
