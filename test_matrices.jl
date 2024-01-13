include("matrices.jl")

using Test
using Distributions
using LinearAlgebra

NUM_GOOD_TESTS = 20
NUM_BAD_TESTS = 10
MAX_DIM = 100

@testset "dot_product" begin
    for i in 1:NUM_GOOD_TESTS
        dim = rand(1:MAX_DIM)
        v⃗₁ = rand(Uniform(-100,100), dim)
        v⃗₂ = rand(Uniform(-100,100), dim)
        @test isapprox(dot_product(v⃗₁,v⃗₂), dot(v⃗₁,v⃗₂))
    end
    for i in 1:NUM_BAD_TESTS÷2
        dim1 = rand(1:MAX_DIM)
        dim2 = dim1 + rand(1:MAX_DIM)
        v⃗₁ = rand(Uniform(-100,100), dim1)
        v⃗₂ = rand(Uniform(-100,100), dim2)
        @test_throws Exception dot_product(v⃗₁,v⃗₂)
        @test_throws Exception dot_product(v⃗₂,v⃗₁)
    end
end

@testset "vector_multiply" begin
    for i in 1:NUM_GOOD_TESTS
        rows = rand(1:MAX_DIM)
        cols = rand(1:MAX_DIM)
        v⃗ = rand(Uniform(-100,100), cols)
        𝕄 = rand(Uniform(-100,100), rows, cols)
        @test isapprox(multiply(𝕄, v⃗), 𝕄*v⃗)
    end
    for i in 1:NUM_BAD_TESTS÷2
        rows = rand(1:MAX_DIM)
        cols = rand(1:MAX_DIM)
        extra = rand(1:MAX_DIM)
        v⃗₁ = rand(Uniform(-100,100), cols)
        v⃗₂ = rand(Uniform(-100,100), cols+extra)
        𝕄₁ = rand(Uniform(-100,100), rows, cols)
        𝕄₂ = rand(Uniform(-100,100), rows, cols+extra)
        @test_throws Exception multiply(𝕄₁,v⃗₂)
        @test_throws Exception multiply(𝕄₂,v⃗₁)
    end
end

@testset "matrix_multiply" begin
    for i in 1:NUM_GOOD_TESTS
        dim1 = rand(1:MAX_DIM)
        dim2 = rand(1:MAX_DIM)
        dim3 = rand(1:MAX_DIM)
        𝕄₁ = rand(Uniform(-100,100), dim1, dim2)
        𝕄₂ = rand(Uniform(-100,100), dim2, dim3)
        @test isapprox(multiply(𝕄₁, 𝕄₂), 𝕄₁*𝕄₂)
    end
    for i in 1:NUM_BAD_TESTS÷2
        dim1 = rand(1:MAX_DIM)
        dim2 = rand(1:MAX_DIM)
        dim3 = rand(1:MAX_DIM)
        extra = rand(1:MAX_DIM)
        𝕄₁ = rand(Uniform(-100,100), dim1, dim2)
        𝕄₂ = rand(Uniform(-100,100), dim2, dim3)
        𝕄₃ = rand(Uniform(-100,100), dim1, dim2+extra)
        𝕄₄ = rand(Uniform(-100,100), dim2+extra, dim3)
        @test_throws Exception multiply(𝕄₁,𝕄₄)
        @test_throws Exception multiply(𝕄₂,𝕄₃)
    end
end

@testset "p_norm" begin
    for i in 1:NUM_GOOD_TESTS
        dim = rand(1:MAX_DIM)
        v⃗ = rand(Uniform(-100,100), dim)
        p = rand(Uniform(0,20))
        @test isapprox(p_norm(v⃗, p), norm(v⃗, p))
    end
end
