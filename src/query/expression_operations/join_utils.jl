# TODO: Document this.
function analyze_src_expr(@nospecialize(e::Any))
    @assert has_alias(e)

    alias, body = get_alias(e)

    Expr(
        :tuple,
        Expr(
            :(=),
            :alias,
            QuoteNode(alias),
        ),
        Expr(
            :(=),
            :source,
            esc(body),
        ),
    )
end

# TODO: Document this.
function _analyze_qualified_column_name(@nospecialize(e::Any))
    @assert isa(e, Expr)
    @assert e.head == :.
    alias, wrapped_column = e.args[1], e.args[2]
    @assert isa(alias, Symbol)
    @assert isa(wrapped_column, QuoteNode)
    column = wrapped_column.value
    alias, column
end

# TODO: Move to tests
# analyze_qualified_column_name(:(a.x)) == (:a, :x)

# TODO: Document this.
function _analyze_simple_equijoin_expression(@nospecialize(e::Any))
    @assert isa(e, Expr)
    @assert e.head == :call && e.args[1] == :(==)
    lhs, rhs = e.args[2], e.args[3]
    lhs_alias, lhs_column = _analyze_qualified_column_name(lhs)
    rhs_alias, rhs_column = _analyze_qualified_column_name(rhs)
    (lhs_alias, rhs_alias), (lhs_column, rhs_column)
end

# TODO: Move to tests
# analyze_simple_equijoin_expression(:(a.x == b.y)) == ((:a, :b), (:x, :y))

# TODO: Document this.
function _predicate_to_pair(predicate::FunctionSpec, lhs, rhs)
    (lhs_alias, rhs_alias), (lhs_column, rhs_column) = (
        _analyze_simple_equijoin_expression(predicate.body)
    )

    # TODO: Handle swapping order of aliase and sources
    @assert lhs_alias == lhs.alias
    @assert rhs_alias == rhs.alias

    lhs_column => rhs_column
end
