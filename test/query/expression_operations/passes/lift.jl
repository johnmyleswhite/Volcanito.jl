module TestExpressionsLift

import Test: @testset, @test
import Volcanito: lift_function_calls

# TODO: Test the proper behavior when it's implemented.
test_cases = (
    (
        input=:(f(x)),
        output=:(f(x)),
    ),
)

@testset "lift" begin
    for case in test_cases
        @test lift_function_calls(case.input) == case.output
    end
end

end
