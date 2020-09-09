module TestMacrosOrderBy

import Test: @testset, @test
import Volcanito: @order_by, materialize
import DataFrames: DataFrame

@testset "@order_by" begin
    df = DataFrame(
        a = [1, 2, 3, 4],
        b = [10, 20, 20, 10],
    )

    plan = @order_by(df, b)
    res = materialize(plan)
    @test res == DataFrame(
        a = [1, 4, 2, 3],
        b = [10, 10, 20, 20],
    )
end

end
