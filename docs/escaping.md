# Escaping

We escape all symbols, except those in an ignore list. The only global item in
this is `uses_default_lifting`, which allows customizing the automatic lifting
system that will be released soon.

Otherwise, the rest of the ignore list is essentially all of the symbols on
the left-hand side of the anonymous function spec, `lhs -> rhs`.
