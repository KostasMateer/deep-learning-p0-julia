
include("gradients.jl")

using Test
using Distributions



NUM_TESTS = 20
DEGREE_DISTR = Categorical([.4, .2, .05, .05, .05, .05, .05, .05, .05, .05])
COEF_DISTR = Normal(0,10)
ALL_VARIABLES = @polyvar x₀ x₁ x₂ x₃ x₄ x₅ x₆ x₇ x₈ x₉

function test_eval(polynomial, point)
    polynomial([var=>val for (var,val) in zip(variables(polynomial), point)]...)
end

function random_polynomial(degree_distr=DEGREE_DISTR, nvars_distr=DEGREE_DISTR, nterms_distr=DEGREE_DISTR, coef_distr=COEF_DISTR)
    num_vars = rand(nvars_distr)
    num_terms = rand(nterms_distr)
    variables = ALL_VARIABLES[1:num_vars]
    polynomial = 0 * prod(variables)
    for term in 1:num_terms
        coef = round.(rand(coef_distr), digits=2)
        exponents = rand(degree_distr, num_vars) .- 1
        polynomial += coef * prod(variables .^ exponents)
    end
    return polynomial
end

function random_point(polynomial, point_distr=COEF_DISTR)
    round.(rand(point_distr, length(variables(polynomial))), digits=2)
end

@testset "evaluate" begin
    for test in 1:NUM_TESTS
        poly = random_polynomial()
        point = random_point(poly)
        @test isapprox(evaluate(poly, point), test_eval(poly, point))
    end
end

@testset "partial_derivative" begin
    for test in 1:NUM_TESTS
        poly = random_polynomial()
        point = random_point(poly)
        for var in variables(poly)
            @test partial_derivative(poly, var) == differentiate(poly, var)
        end
    end
end

@testset "symbolic_gradient" begin
    for test in 1:NUM_TESTS
        poly = random_polynomial()
        point = random_point(poly)
        @test symbolic_gradient(poly) == differentiate(poly, variables(poly))
    end
end
