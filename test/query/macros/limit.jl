module TestMacrosLimit

import Test: @testset, @test
import Volcanito: @limit, materialize
import DataFrames: DataFrame

@testset "@inner_join" begin
    df = DataFrame(
        a = [1, 2],
        b = [10, 20],
    )

    plan = @limit(df, 1)
    res = materialize(plan)
    @test res == DataFrame(
        a = [1],
        b = [10],
    )
end

end
