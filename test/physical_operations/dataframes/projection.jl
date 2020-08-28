module TestFunctionsSelect

import Test: @testset, @test
import Volcanito: Projection
import DataFrames: DataFrame

df = DataFrame(
    a = [1, 2, 3, 4],
    b = [2, 3, 4, 5],
)

# TODO: Add tests here.

# select(
#     df,
#     (:a, :b),
#     (
#         t -> t[1] + t[2],
#         t -> sin(t[1] * t[2]),
#     ),
#     (:c, :d),
# )

# @test res == DataFrame(c = [3, 5, 7, 9])

end
