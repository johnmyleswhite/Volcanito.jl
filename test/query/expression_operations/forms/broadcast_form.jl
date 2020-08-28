module TestExpressionsBroadcastForm

import Test: @testset, @test
import Volcanito: broadcast_form
import MacroTools: postwalk, rmlines

@testset "broadcast_form" begin
    input = broadcast_form(
        :(y + x + $(Expr(:$, :z))),
        (:x, :y),
    )
    output = :((x, y) -> y + x + z)

    @test postwalk(rmlines, input) == postwalk(rmlines, output)
end

end
