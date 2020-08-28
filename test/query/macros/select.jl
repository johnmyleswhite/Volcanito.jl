module TestMacrosSelect

import Test: @testset, @test
import Volcanito: @select, materialize
import DataFrames: DataFrame

@testset "@select" begin
    df = DataFrame(
        a = [1, 2, 3, 4],
        b = [2, 3, 4, 5],
    )

    plan = @select(df, c = a + b)
    res = materialize(plan)
    @test res == DataFrame(c = [3, 5, 7, 9])
end

end
