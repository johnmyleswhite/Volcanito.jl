module TestExpressionsLocals

import Test: @testset, @test
import Volcanito: unescape_locals

input_output = (
    (
        input=:(a + b + $(Expr(:$, :c))),
        output=:(a + b + c),
    ),
)

@testset "unescape_locals" begin
    for pair in input_output
        @test unescape_locals(pair.input) == pair.output
    end
end

end
