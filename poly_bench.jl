using BenchmarkTools, Polynomials, ForwardDiff

const cnst = [
    -10.5       0.074       -6.96e-5    ;
    0.668e-3    -1.78e-5    2.80e-8     ;
    0.494e-6    -8.86e-10   0           ;
]
const p1 = Polynomial(cnst[1, end:-1:1])
const p2 = Polynomial(cnst[2, end:-1:1])
const p3 = Polynomial(cnst[3, end:-1:1])

##

@inline function f(T::Real, C::Real)
    fact = 1e-4
    return fact * C * (p1(C) + p2(C) * T + p3(C) * T^2)^2
end

function get_ad_array(n, m, k; vals=nothing)
    v = Vector{ForwardDiff.Dual{Nothing, Float64, m}}(undef, n)
    diff = (i == k ? 1. : 0. for i ∈ 1:m)
    for i ∈ 1:n
        val = isnothing(vals) ? 0. : vals[i]
        a =  ForwardDiff.Dual(val, diff...)
        v[i] = a
    end
    return v
end


##

n = 1_000_000
m = 2

v1 = rand(n)
v2 = rand(n)

x = Vector{Float64}(undef, n)
y = get_ad_array(n, m, nothing)

C = get_ad_array(n, m, 1; vals=v1)
T = get_ad_array(n, m, 2; vals=v2)

##
@benchmark x .= f.(v1, v2)
##
@benchmark y .= f.(C, T)
