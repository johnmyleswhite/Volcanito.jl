module Volcanito

export
    @select,
    @where,
    @group_by,
    @aggregate_vector,
    @order_by,
    @limit,
    @inner_join,
    @left_join,
    @right_join,
    @outer_join,
    materialize

import DataFrames
import MacroTools: inexpr, postwalk
import Printf: @printf

include("query/expression_operations/column_name.jl")
include("query/expression_operations/remove_backticks.jl")
include("query/expression_operations/validate.jl")
include("query/expression_operations/get_alias.jl")
include("query/expression_operations/find_column_names.jl")
include("query/expression_operations/index_column_names.jl")
include("query/expression_operations/gensym_index.jl")
include("query/expression_operations/rewrite_column_names.jl")
include("query/expression_operations/safe_tuple_name.jl")
include("query/expression_operations/predicates.jl")
include("query/expression_operations/fusion.jl")
include("query/expression_operations/passes/locals.jl")
include("query/expression_operations/passes/lift.jl")
include("query/expression_operations/passes/tvl.jl")
include("query/expression_operations/forms/tuple_form.jl")
include("query/expression_operations/forms/broadcast_form.jl")
include("query/expression_operations/forms/vector_form.jl")
include("query/expression_operations/expression/column_names_tuple_expr.jl")
include("query/expression_operations/expression/expression.jl")
include("query/expression_operations/join_utils.jl")

include("query/macros/expression_macro_call.jl")
include("query/macros/select.jl")
include("query/macros/where.jl")
include("query/macros/group_by.jl")
include("query/macros/aggregate_vector.jl")
include("query/macros/order_by.jl")
include("query/macros/limit.jl")
include("query/macros/inner_join.jl")
include("query/macros/left_join.jl")
include("query/macros/right_join.jl")
include("query/macros/outer_join.jl")

include("logical_nodes/logical_node.jl")
include("logical_nodes/projection.jl")
include("logical_nodes/selection.jl")
include("logical_nodes/group_by.jl")
include("logical_nodes/aggregate_vector.jl")
include("logical_nodes/order_by.jl")
include("logical_nodes/limit.jl")
include("logical_nodes/join.jl")

include("physical_operations/dataframes/iterators.jl")
include("physical_operations/dataframes/materialize.jl")
include("physical_operations/dataframes/generate_column.jl")
include("physical_operations/dataframes/projection.jl")
include("physical_operations/dataframes/selection.jl")
include("physical_operations/dataframes/group_by.jl")
include("physical_operations/dataframes/aggregate_vector.jl")
include("physical_operations/dataframes/order_by.jl")
include("physical_operations/dataframes/limit.jl")
include("physical_operations/dataframes/join.jl")

end
