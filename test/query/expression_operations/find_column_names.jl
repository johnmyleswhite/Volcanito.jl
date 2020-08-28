module TestExpressionsFindColumnNames

import Test: @testset, @test
import Volcanito: find_column_names

test_cases = (
    (
        input = :(a + b + sin(c)),
        output = (:a, :b, :c),
    ),
    (
        input = :(x + sin(y) + cos(z^2) + $(Expr(:$, :a))),
        output = (:x, :y, :z),
    ),
    (
        input = :(1 + exp(x) + y),
        output = (:x, :y),
    ),
    (
        input = :(1 + exp(x) + y + $(Expr(:$, :z))),
        output = (:x, :y),
    ),
    (
        input = :(1 + exp(x, e = z) + y + $(Expr(:$, :z))),
        output = (:x, :y, :z),
    ),
)

@testset "find_column_names" begin
    for case in test_cases
        @test sort([find_column_names(case.input)...]) == sort([case.output...])
    end
end

end
