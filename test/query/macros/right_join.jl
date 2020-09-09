module TestMacrosRightJoin

import Test: @testset, @test
import Volcanito: @right_join, materialize
import DataFrames: DataFrame

@testset "@right_join" begin
    df1 = DataFrame(
        a = [1, 2],
        b = [10, 20],
    )

    df2 = DataFrame(
        c = [1, 1, 2, 2],
        d = [4, 3, 2, 1],
    )

    plan1 = @right_join(a = df1, b = df2, a.a == b.c)
    res1 = materialize(plan1)
    @test res1 == DataFrame(
        a = [1, 1, 2, 2],
        b = [10, 10, 20, 20],
        d = [4, 3, 2, 1],
    )

    # plan2 = @right_join(a = df2, b = df1, a.c == b.a)
    # res2 = materialize(plan2)
    # @test res1 == DataFrame(
    #     c = [10, 10, 20, 20],
    #     d = [4, 3, 2, 1],
    #     b = [1, 1, 2, 2],
    # )
end

end
