using Plots

function trapezoid(f, a, b, n)
    dx = (b - a) / n
    s = 0
    for i in 0:n - 1
        s += (f(a + i * dx) + f(a + (i + 1) * dx)) / 2 * dx
    end
    return s
end

# Expands f in a basis. Returns the n first expansion coefficients
# TODO: allow for different basis and integration schemes
function series_expansion(f, basis, n, a, b, w = 1)

    integral(f) = trapezoid(f, a, b, 1000)
    coeff = zeros(n)
    for i in 1:n
        g(x) = 2 / (b - a) * f(x) * basis(i - 1, x)
        coeff[i] = integral(g)
    end
    coeff[1] = coeff[1] / 2
    return coeff
end

a = -1
b = 1
n = 10000
m = 50
x = Vector(LinRange(a, b, n))

f(x) = x^3 + x + 1
basis(n, x) = cos(n * 2pi * x / (b - a))
c = series_expansion(f, basis, m, a, b)

for k in 1:m
    a = zeros(n)
    for i in 1:k
        a += c[i] * basis.(i - 1, x)
        # a += c[m + i] * basis.(-n + i - 1, -x)
    end

    plot(x, [f.(x), a])
    plot!(show = true)
    # sleep(0.01)
end