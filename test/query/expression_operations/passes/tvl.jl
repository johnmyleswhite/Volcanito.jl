module TestExpressionsTVL

import Test: @testset, @test
import Volcanito: tvl, @tvl

@testset "TVL || truth table" begin
    @test @tvl(true || true) === true
    @test @tvl(true || false) === true
    @test @tvl(true || missing) === true
    @test @tvl(false || true) === true
    @test @tvl(false || false) === false
    @test @tvl(false || missing) === missing
    @test @tvl(missing || true) === true
    @test @tvl(missing || false) === missing
    @test @tvl(missing || missing) === missing
end

@testset "TVL && truth table" begin
    @test @tvl(true && true) === true
    @test @tvl(true && false) === false
    @test @tvl(true && missing) === missing
    @test @tvl(false && true) === false
    @test @tvl(false && false) === false
    @test @tvl(false && missing) === false
    @test @tvl(missing && true) === missing
    @test @tvl(missing && false) === false
    @test @tvl(missing && missing) === missing
end

# We define a function that prints out a unique ID for each argument
# to a Boolean operator. By wrapping all Boolean values in calls to this
# function, we're able to check that the order of evaluation and
# side-effects of the short-circuiting operators are retained by our
# macro rewrites.

function f(io, i, x)
    print(io, i)
    x
end

@testset "Order of evaluation for tvl" begin
    for x in (true, false)
        for y in (true, false)
            for z in (true, false)
                io = IOBuffer()

                a = f(io, 1, x) && f(io, 2, y) || f(io, 3, z)
                order_a = String(take!(io))
                b = @tvl f(io, 1, x) && f(io, 2, y) || f(io, 3, z)
                order_b = String(take!(io))

                @test a === b
                @test order_a === order_b

                a = f(io, 1, x) || f(io, 2, y) && f(io, 3, z)
                order_a = String(take!(io))
                b = @tvl f(io, 1, x) || f(io, 2, y) && f(io, 3, z)
                order_b = String(take!(io))

                @test a === b
                @test order_a === order_b
            end
        end
    end
end

@testset "@tvl with local variables" begin
    let x = 1, y = 2
        @test (@tvl x > 1 || y < 2) === false
    end
end

end
