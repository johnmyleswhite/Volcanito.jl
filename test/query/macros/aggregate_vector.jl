module TestMacrosAggregateVector

import Test: @testset, @test
import Volcanito: @group_by, @aggregate_vector, materialize
import DataFrames: DataFrame
import Statistics: mean

@testset "@aggregate_vector" begin
    df = DataFrame(
        a = [1, 2, 3, 4],
        b = [2, 3, 4, 5],
        c = [0, 0, 1, 1],
    )

    plan1 = @group_by(df, c)
    gdf = materialize(plan1)

    plan2 = @aggregate_vector(gdf, m = mean(a + b))
    res = materialize(plan2)
    @test res == DataFrame(
        c = [0, 1],
        m = [mean([1 + 2, 2 + 3]), mean([3 + 4, 4 + 5])],
    )
end

end
