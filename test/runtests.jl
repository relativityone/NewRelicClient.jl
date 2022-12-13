using NewRelicClient
using Test

@testset "utils.jl" begin
    @test NewRelicClient.finddictkeys([Dict("x"=>Dict("y"=>1))]) == Set(["x"])
    @test isnothing(NewRelicClient.finddictkeys([Dict("x"=>1)]))
    @test issetequal(NewRelicClient.getuniquekeys([Dict("x"=>1)]), Set([keys(Dict("x"=>1))]))
end

@testset "parser.jl" begin 
    @test NewRelicClient.arraytodataframe([Dict("A"=>1)]) == DataFrame(A=Int64[1])
end