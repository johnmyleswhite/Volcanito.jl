module TestHarness

import DataFrames
import MacroTools
import Pkg
import Test: @testset

Pkg.activate("..")

anyerrors = false

println("Running tests:")

paths = (
    "query/expression_operations/validate.jl",
    "query/expression_operations/get_alias.jl",
    "query/expression_operations/find_column_names.jl",
    "query/expression_operations/index_column_names.jl",
    "query/expression_operations/rewrite_column_names.jl",
    "query/expression_operations/safe_tuple_name.jl",
    "query/expression_operations/predicates.jl",
    "query/expression_operations/fusion.jl",
    "query/expression_operations/passes/locals.jl",
    "query/expression_operations/passes/lift.jl",
    "query/expression_operations/passes/tvl.jl",
    "query/expression_operations/forms/tuple_form.jl",
    "query/expression_operations/forms/broadcast_form.jl",
    "query/expression_operations/function_spec/as_expr.jl",
    "query/expression_operations/function_spec/function_spec.jl",

    "query/macros/select.jl",
    "query/macros/where.jl",
    "query/macros/group_by.jl",
    "query/macros/aggregate_vector.jl",
    "query/macros/order_by.jl",
    "query/macros/limit.jl",
    "query/macros/inner_join.jl",
    "query/macros/left_join.jl",
    "query/macros/right_join.jl",
    "query/macros/outer_join.jl",

    "logical_nodes/projection.jl",
    "logical_nodes/selection.jl",
    "logical_nodes/group_by.jl",
    "logical_nodes/aggregate_vector.jl",
    "logical_nodes/order_by.jl",
    "logical_nodes/limit.jl",
    "logical_nodes/inner_join.jl",
    "logical_nodes/left_join.jl",
    "logical_nodes/right_join.jl",
    "logical_nodes/outer_join.jl",

    "physical_operations/dataframes/iterators.jl",
    "physical_operations/dataframes/projection.jl",
    "physical_operations/dataframes/selection.jl",
    "physical_operations/dataframes/group_by.jl",
    "physical_operations/dataframes/aggregate_vector.jl",
    "physical_operations/dataframes/order_by.jl",
    "physical_operations/dataframes/limit.jl",
    "physical_operations/dataframes/inner_join.jl",
    "physical_operations/dataframes/left_join.jl",
    "physical_operations/dataframes/right_join.jl",
    "physical_operations/dataframes/outer_join.jl",
)

@testset "All tests" begin
    for path in paths
        try
            include(path)
            println("\t\033[1m\033[32mPASSED\033[0m: $(path)")
        catch e
            global anyerrors = true
            println("\t\033[1m\033[31mFAILED\033[0m: $(path)")
            showerror(stdout, e, backtrace())
            println()
        end
    end
end

if anyerrors
    throw("Tests failed")
end

end
