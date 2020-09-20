module TestExpressionsAsExpr

import Test: @testset, @test
import Volcanito: column_names_tuple_expr, ColumnName

test_cases = (
    (
        input = (ColumnName(:a, false), ColumnName(:b, false)),
        output = Expr(:tuple, QuoteNode(:a), QuoteNode(:b)),
    ),
)

@testset "column_names_tuple_expr" begin
    for case in test_cases
        @test sort([eval(column_names_tuple_expr(case.input))...]) == sort([eval(case.output)...])
    end
end

end
