"""
Materialize a `Selection` into a `DataFrame`.
"""
function materialize(node::Selection)
    mask = generate_column(node.source, node.predicate)
    @assert eltype(mask) <: Union{Missing, Bool}
    materialize(node.source)[coalesce.(mask, false), :]
end
