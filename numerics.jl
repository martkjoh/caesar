using Plots
using LinearAlgebra

function trapezoid(f, a, b, n)
    dx = (b - a) / n
    s = 0
    for i in 0:n - 1
        s += (f(a + i * dx) + f(a + (i + 1) * dx)) / 2 * dx
    end
    return s
end

# Returns array with fourier coeff for freq j at index n + j + 1,
# i.e. f(x) ~ sum_j=n^-n c[n+j+1]e^(i2pi * j x/(b - a)) 
function DFT(f, n, a, b)
    k = -2pi*im/(b - a) * LinRange{Float32}(-n, n, 2n + 1)
    x = LinRange{Float32}(a, b, n)
    fx = f.(x)
    c = zeros(ComplexF64, 2n + 1)
    for i in 1:2n + 1
        for j in 1:n
            c[i] += exp(k[i] * x[j]) * fx[j] / n
        end
    end
    return c
end

f(x) = x^3 + x^2 - x 

n = 100:100:5000
t = zeros(length(n))
a = -2
b = 3

for i in 1:length(n)
    t[i] = @elapsed DFT(f, n[i], a, b)
end

plot(n, t)
savefig("t(n)_DFT_Julia")