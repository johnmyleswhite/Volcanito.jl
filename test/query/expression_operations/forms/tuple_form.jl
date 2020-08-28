module TestExpressionsTupleForm

import Test: @testset, @test
import Volcanito: tuple_form
import MacroTools: postwalk, rmlines

@testset "tuple_form" begin
    input = tuple_form(
        :(x + y),
        :t,
        Dict(:x => 1, :y => 2),
    )

    output = :(t -> t[1] + t[2])

    @test postwalk(rmlines, input) == postwalk(rmlines, output)

    input = tuple_form(
        :(y + x + $(Expr(:$, :z))),
        :t,
        Dict(:x => 1, :y => 2),
    )

    output = :(t -> t[2] + t[1] + z)

    @test postwalk(rmlines, input) == postwalk(rmlines, output)
end

end
