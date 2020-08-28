module TestExpressionsFusion

import Test: @testset, @test
import Volcanito: fuse_conjunction

@testset "fuse_conjunction" begin
    test_cases = (
        (
            input = (:(x > y || z == 0), :(y < z)),
            output = :((x > y || z == 0) && y < z),
        ),
        (
            input = (:(x), :(y)),
            output = :(x && y),
        ),
        (
            input = (:(x > y), :(y < z)),
            output = :(x > y && y < z),
        ),
        (
            input = (:(a > 0), :(b < 1)),
            output = :(a > 0 && b < 1),
        ),
    )
    for case in test_cases
        @test fuse_conjunction(case.input) == case.output
    end
end

end
