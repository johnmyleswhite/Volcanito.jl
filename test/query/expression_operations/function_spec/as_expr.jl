module TestExpressionsAsExpr

import Test: @testset, @test
import Volcanito: as_expr

test_cases = (
    (
        input = (:a, :b),
        output = :((:a, :b)),
    ),
    (
        input = Dict(:a => 1, :b => 2),
        output = :(Dict{Symbol, Int}(:a => 1, :b => 2)),
    ),
)

@testset "as_expr" begin
    for case in test_cases
        @test as_expr(case.input) == case.output
    end
end

end
