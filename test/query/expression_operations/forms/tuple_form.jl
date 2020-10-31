module TestExpressionsTupleForm

import Test: @testset, @test
import Volcanito: tuple_form, ColumnName
import MacroTools: postwalk, rmlines

@testset "tuple_form" begin
    input = tuple_form(
        :(x + y),
        (ColumnName(:x, false), ColumnName(:y, false)),
    )

    output = :(t -> $(Expr(:escape, :+))(t[1], t[2]))

    @test postwalk(rmlines, input) == postwalk(rmlines, output)

    input = tuple_form(
        :(y + x + $(Expr(:$, :z))),
        (ColumnName(:x, false), ColumnName(:y, false)),
    )

    output = :(t -> $(Expr(:escape, :+))(t[2], t[1], $(Expr(:escape, :z))))

    @test postwalk(rmlines, input) == postwalk(rmlines, output)
end

end
