module TestExpression

import Test: @testset, @test
import Volcanito: expression_expr, @expression, ColumnName

sort_tuple(t) = (sort([t...])..., )

@testset "@expression(a + b)" begin
    s = @expression(a + b)

    @test s.raw_form == :(a + b)
    @test sort_tuple(s.input_columns) == sort_tuple((:a, :b))
    @test s.tuple_form((1, 2)) == 1 + 2
    @test s.broadcast_form(1, 2) == 1 + 2
end

@testset "@expression(sin(a + b))" begin
    s = @expression(sin(a + b))

    @test s.raw_form == :(sin(a + b))
    @test sort_tuple(s.input_columns) == sort_tuple((:a, :b))
    @test s.tuple_form((1, 2)) == sin(1 + 2)
    @test s.broadcast_form(1, 2) == sin(1 + 2)
end

@testset "@expression(1)" begin
    s = @expression(1)

    @test s.raw_form == :(1)
    @test sort_tuple(s.input_columns) == sort_tuple(())
    @test s.tuple_form(()) == 1
    @test s.broadcast_form() == 1
end

@testset "@expression(a)" begin
    s = @expression(a)

    @test s.raw_form == :a
    @test sort_tuple(s.input_columns) == sort_tuple((:a, ))
    @test s.tuple_form((1, )) == 1
    @test s.broadcast_form(1) == 1
end

end
