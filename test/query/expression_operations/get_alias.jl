module TestExpressionsAliases

import Test: @testset, @test
import Volcanito: get_alias

test_cases = (
    (
        input = :x,
        output = (:x, :x),
    ),
    (
        input = :(x = a + sin(b)),
        output = (:x, :(a + sin(b))),
    ),
    (
        input = :(x = 1),
        output = (:x, 1),
    ),
    (
        input = :(x = 1 + y),
        output = (:x, :(1 + y)),
    ),
    (
        input = :(1 + y),
        output = (Symbol("1 + y"), :(1 + y)),
    ),
)

@testset "get_alias" begin
    for case in test_cases
        @test get_alias(case.input) == case.output
    end
end

end
