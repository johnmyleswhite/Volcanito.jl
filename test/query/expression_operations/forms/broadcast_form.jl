module TestExpressionsBroadcastForm

import Test: @testset, @test
import Volcanito: broadcast_form, ColumnName
import MacroTools: postwalk, rmlines

@testset "broadcast_form" begin
    input = broadcast_form(
        :(y + x + $(Expr(:$, :z))),
        (ColumnName(:x, false), ColumnName(:y, false)),
    )
    output = :((x, y) -> y + x + z)

    # @test postwalk(rmlines, input) == postwalk(rmlines, output)
end

end
