module TestFunctionsGroupBy

import Test: @testset, @test
import Volcanito: GroupBy
import DataFrames: DataFrame

df = DataFrame(
    a = [1, 2, 3, 4],
    b = [2, 3, 4, 5],
)

# TODO: Add tests here.

# group_by(
#     df,
#     (:a, :b),
#     (
#         t -> t[1] > t[2],
#     ),
#     (Symbol("a > b"),)
# )

end
