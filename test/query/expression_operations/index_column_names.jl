module TestExpressionsIndexColumnNames

import Test: @testset, @test
import Volcanito: index_column_names, ColumnName

test_cases = (
    (
        input = (ColumnName(:a, false), ColumnName(:b, false)),
        output = Dict(ColumnName(:a, false) => 1, ColumnName(:b, false) => 2),
    ),
    (
        input = (
            ColumnName(:a, false),
            ColumnName(:b, false),
            ColumnName(:c, false),
        ),
        output = Dict(
            ColumnName(:a, false) => 1,
            ColumnName(:b, false) => 2,
            ColumnName(:c, false) => 3,
        ),
    ),
)

@testset "index_column_names"  begin
    for case in test_cases
        @test index_column_names(case.input) == case.output
    end
end

end
