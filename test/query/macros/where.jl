module TestMacrosWhere

import Test: @testset, @test
import Volcanito: @where, materialize
import DataFrames: DataFrame

@testset "@where" begin
    df = DataFrame(
        a = [1, 2, 3, 4],
        b = [2, 3, 4, 5],
    )

    plan1 = @where(df, a < b)
    res1 = materialize(plan1)
    @test res1 == df

    plan2 = @where(df, a > 1)
    res2 = materialize(plan2)
    @test res2 == df[2:4, :]
end

end
