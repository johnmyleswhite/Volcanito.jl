module TestExpressionsIndexColumnNames

import Test: @testset, @test
import Volcanito: index_column_names

test_cases = (
    (
        input = (:a, :b),
        output = Dict(:a => 1, :b => 2),
    ),
    (
        input = (:a, :b, :c),
        output = Dict(:a => 1, :b => 2, :c => 3),
    ),
)

@testset "index_column_names"  begin
    for case in test_cases
        @test index_column_names(case.input) == case.output
    end
end

end
