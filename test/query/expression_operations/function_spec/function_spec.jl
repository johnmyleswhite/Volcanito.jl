module TestFunctionSpec

import Test: @testset, @test
import Volcanito: function_spec_expr, @function_spec

@testset "@function_spec(a + b)" begin
    s = @function_spec(a + b)

    @test s.raw_form == :(a + b)
    @test s.input_columns == (:a, :b)
    @test s.column_index == Dict(:a => 1, :b => 2)
    @test s.tuple_form((1, 2)) == 1 + 2
    @test s.broadcast_form(1, 2) == 1 + 2
    @test s.explicit_alias === false
    @test s.is_constant === false
    @test s.is_column === false
end

@testset "@function_spec(sin(a + b))" begin
    s = @function_spec(sin(a + b))

    @test s.raw_form == :(sin(a + b))
    @test s.input_columns == (:a, :b)
    @test s.column_index == Dict(:a => 1, :b => 2)
    @test s.tuple_form((1, 2)) == sin(1 + 2)
    @test s.broadcast_form(1, 2) == sin(1 + 2)
    @test s.explicit_alias === false
    @test s.is_constant === false
    @test s.is_column === false
end

@testset "@function_spec(1)" begin
    s = @function_spec(1)

    @test s.raw_form == :(1)
    @test s.input_columns == ()
    @test s.column_index == Dict{Symbol, Int}()
    @test s.tuple_form(()) == 1
    @test s.broadcast_form() == 1
    @test s.explicit_alias === false
    @test s.is_constant === true
    @test s.is_column === false
end

@testset "@function_spec(a)" begin
    s = @function_spec(a)

    @test s.raw_form == :a
    @test s.input_columns == (:a, )
    @test s.column_index == Dict(:a => 1)
    @test s.tuple_form((1, )) == 1
    @test s.broadcast_form(1) == 1
    @test s.explicit_alias === false
    @test s.is_constant === false
    @test s.is_column === true
end

end
