module TestExpressionsRewriteColumnNames

import Test: @testset, @test
import Volcanito: rewrite_column_names

@testset "rewrite_column_names" begin
    input = rewrite_column_names(
        :(a + b),
        :t,
        Dict(:a => 1, :b => 2),
    )

    output = :(t[1] + t[2])

    @test input == output
end

end
