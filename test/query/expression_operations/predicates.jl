module TestExpressionsPredicates

import Test: @testset, @test
import Volcanito: is_column, is_constant

@testset "is_column" begin
    @test is_column(:x) === true
    @test is_column(1) === false
    @test is_column(:(a + b)) === false
end

@testset "is_constant" begin
    @test is_constant(:x) === false
    @test is_constant(1) === true
    @test is_constant(:(a + b)) === false
end

end
