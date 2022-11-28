using NewRelicClient
using Test

@testset "utils.jl" begin
    @test NewRelicClient.finddictkeys([Dict("x"=>Dict("y"=>1))]) == Set(["x"])
    @test NewRelicClient.finddictkeys([Dict("x"=>1)]) == nothing
    @test issetequal(NewRelicClient.getuniquekeys([Dict("x"=>1)]), Set([keys(Dict("x"=>1))]))
end
