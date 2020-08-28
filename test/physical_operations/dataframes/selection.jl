module TestFunctionsWhere

import Test: @testset, @test
import Volcanito: Selection
import DataFrames: DataFrame

df = DataFrame(
    a = [1, 2, 3, 4],
    b = [2, 3, 4, 5],
)

# TODO: Add tests here.

# where(
#     df,
#     (:a, :b),
#     (
#         t -> t[1] > t[2],
#     ),
# )

end
