module TestIterators

import DataFrames: DataFrame
import Volcanito: columns_tuple, tuple_iterator
import Test: @testset, @test

@testset "Iterators" begin
    df = DataFrame(a = [1, 2, 3], b = [2, 3, 4])

    @test columns_tuple(df, (:a, :b)) == (df[:a], df[:b])

    tuples = collect(tuple_iterator(df, (:a, :b)))
    @test tuples == [(1, 2), (2, 3), (3, 4)]
end

end
