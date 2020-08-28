module Volcanito

export
    @select,
    @where,
    @group_by,
    @aggregate_vector,
    @order_by,
    @limit,
    materialize

import DataFrames
import MacroTools: inexpr, postwalk
import Printf: @printf

include("query/expression_operations/validate.jl")
include("query/expression_operations/get_alias.jl")
include("query/expression_operations/find_column_names.jl")
include("query/expression_operations/index_column_names.jl")
include("query/expression_operations/rewrite_column_names.jl")
include("query/expression_operations/safe_tuple_name.jl")
include("query/expression_operations/predicates.jl")
include("query/expression_operations/fusion.jl")
include("query/expression_operations/passes/locals.jl")
include("query/expression_operations/passes/lift.jl")
include("query/expression_operations/passes/tvl.jl")
include("query/expression_operations/forms/tuple_form.jl")
include("query/expression_operations/forms/broadcast_form.jl")
include("query/expression_operations/function_spec/as_expr.jl")
include("query/expression_operations/function_spec/function_spec.jl")

include("query/macros/select.jl")
include("query/macros/where.jl")
include("query/macros/group_by.jl")
include("query/macros/aggregate_vector.jl")
include("query/macros/order_by.jl")
include("query/macros/limit.jl")

include("logical_nodes/logical_node.jl")
include("logical_nodes/projection.jl")
include("logical_nodes/selection.jl")
include("logical_nodes/group_by.jl")
include("logical_nodes/aggregate_vector.jl")
include("logical_nodes/order_by.jl")
include("logical_nodes/limit.jl")

include("physical_operations/dataframes/iterators.jl")
include("physical_operations/dataframes/materialize.jl")
include("physical_operations/dataframes/projection.jl")
include("physical_operations/dataframes/selection.jl")
include("physical_operations/dataframes/group_by.jl")
include("physical_operations/dataframes/aggregate_vector.jl")
include("physical_operations/dataframes/order_by.jl")
include("physical_operations/dataframes/limit.jl")

end
