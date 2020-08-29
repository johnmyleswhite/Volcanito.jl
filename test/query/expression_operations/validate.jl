module TestExpressionsValidate

import Test: @testset, @test, @test_throws
import Volcanito: validate

@testset "validate" begin
    @test_throws Exception validate(:([x + 1 for x in 1:10]))
    @test_throws Exception validate(:((a; b; c;)))
    @test_throws Exception validate(:(import Foo))
    @test_throws Exception validate(:(export foo))
    @test_throws Exception validate(:(while true; 1; end))
    @test_throws Exception validate(:(for x in 1:1; 1; end))
    @test_throws Exception validate(:(break))
    @test_throws Exception validate(:(continue))
    @test_throws Exception validate(:(let x = 1; x; end))
    @test_throws Exception validate(:(struct Foo; x; end))
    @test_throws Exception validate(:(mutable struct Foo; x; end))
    @test validate(:x) === nothing
    @test validate(1) === nothing
    @test validate("a") === nothing
    @test validate(:(1 + sin(x))) === nothing
    @test validate(:(1 + sin(x, y = 1))) === nothing
end

end
