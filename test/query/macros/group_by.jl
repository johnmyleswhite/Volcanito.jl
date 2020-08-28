module TestMacrosGroupBy

import Test: @testset, @test
import Volcanito: @group_by, materialize
import DataFrames: DataFrame, groupby

@testset "@group_by" begin
    df = DataFrame(
        a = [1, 2, 3, 4],
        b = [2, 3, 4, 5],
    )

    plan = @group_by(df, a) 
    res = materialize(plan)
    @test res == groupby(df, :a)
end

end
