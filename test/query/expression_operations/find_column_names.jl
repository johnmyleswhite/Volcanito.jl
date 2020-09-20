module TestExpressionsFindColumnNames

import Test: @testset, @test
import Volcanito: find_column_names, ColumnName

test_cases = (
    (
        input = :(a + b + sin(c)),
        output = (
            ColumnName(:a, false),
            ColumnName(:b, false),
            ColumnName(:c, false),
        ),
    ),
    (
        input = :(x + sin(y) + cos(z^2) + $(Expr(:$, :a))),
        output = (
            ColumnName(:x, false),
            ColumnName(:y, false),
            ColumnName(:z, false),
        ),
    ),
    (
        input = :(1 + exp(x) + y),
        output = (
            ColumnName(:x, false),
            ColumnName(:y, false),
        ),
    ),
    (
        input = :(1 + exp(x) + y + $(Expr(:$, :z))),
        output = (
            ColumnName(:x, false),
            ColumnName(:y, false),
        ),
    ),
    (
        input = :(1 + exp(x, e = z) + y + $(Expr(:$, :z))),
        output = (
            ColumnName(:x, false),
            ColumnName(:y, false),
            ColumnName(:z, false),
        ),
    ),
)

@testset "find_column_names" begin
    for case in test_cases
        @test sort([find_column_names(case.input)...]) == sort([case.output...])
    end
end

end
