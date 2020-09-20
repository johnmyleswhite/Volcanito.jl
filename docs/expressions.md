# Expression Objects

* alias: The alias that should be associated with the result of evaluating that
    expression.
* body: The raw body of the expression without modification.
* raw_form: The raw input form provided by the user.
* input_columns: A tuple of the column names as symbols.
* column_index: A `Dict{Symbol, Int}` mapping column names to numeric indices.
* tuple_form: The expression rewritten into a function that can be applied to
    rows passes as tuples.
* broadcast_form: The expression rewritten into a function that can be applied
    to rows passed as individual variables.
* vector_form: The expression rewritten into a function that can be applied
    to columns passed as individual variables.
