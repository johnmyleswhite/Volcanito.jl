# Function Specs

* alias: The alias that should be associated with the result of evaluating that
    expression.
* body: The raw body of the expression without modification.
* raw_form: The raw input form provided by the user.
* input_columns: A tuple of the column names as symbols.
* column_index: A `Dict{Symbol, Int}` mapping column names to numeric indices.
* tuple_form: The expression rewritten into a function that can be applied to
    rows passes as tuples.
* broadcast_form: The expression rewritten into a function that can be applied
    to rows passes as individual variables.
* explicit_alias: Did `raw_form` contain the alias or was the alias constructed
    as part of the `FunctionSpec` constructor?
* is_constant: Was the `body` a single constant that doesn't need a function to
    be computed?
* is_column: Was the `body` the name of a single column that can be copied
    rather than recomputed?
