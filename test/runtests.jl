using NewRelicClient
using Test

@testset "NewRelicClient.jl" begin
    @test finddictkeys([Dict("x"=>Dict("y"=>1))]) == Set(["x"])
    @test finddictkeys([Dict("x"=>1)]) == nothing
end
