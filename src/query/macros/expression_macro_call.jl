function expression_macro_call(e, source)
    Expr(
        :macrocall,
        Symbol("@expression"),
        source,
        protect_splice(e),
        # Need to walk down tree and replace Expr(:$, x) with QuoteNode(Expr(:$, x))
    )
end

import MacroTools: postwalk

function protect_splice(e_in)
    postwalk(e -> isa(e, Expr) && e.head == :$ ? esc(e) : e, e_in)
end
