module TestExpressionsSafeTupleName

import Test: @testset, @test
import Volcanito: safe_tuple_name

@testset "safe_tuple_name" begin
    @test safe_tuple_name(:(x + y)) == :t
    @test safe_tuple_name(:(x + t)) != :t
end

end
