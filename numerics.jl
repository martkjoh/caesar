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

function DFT(f, n, a, b)
    k = -2pi * im * LinRange(-n, n, 2n + 1)
    x = LinRange(a, b, n) / (b - a)
    c = zeros(ComplexF64, 2n + 1)
    for i in 1:2n + 1
        for j in 1:n
            c[i] += exp(k[i] * x[j]) * f[j] / n
        end
    end
    return c
end

function main()
    a = -2
    b = 3
    n = 1000
    m = 40
    x = Vector(LinRange(a, b, n))

    f(x) = x^3 + x^2 - x 
    c = DFT(f.(x), n, a, b)

    for i in 1:m
        d = ones(n) * c[n + 1]
        for j in 1:i
            d += c[n - j + 1] * exp.(2pi*im * (-j)*x/(b - a))
            d += c[n + j + 1] * exp.(2pi*im * j*x/(b - a))
        end

        plot(x, f.(x))
        plot!(x, real(d))
        plot!(show = true)
        sleep(0.45)
    end
end

main()