function trapezoid(f, a, b, n)
    dx = (b - a) // n
    s = 0
    for i in 0:n - 1
        s += (f(a + i * dx) + f(a + (i + 1) * dx)) / 2 * dx
    end
    return float(s)
end
    
a = 0
b = 4

f(x) = exp(2x)
If(x) = 1 / 2 * exp(2x)

print(trapezoid(f, a, b, 100), "\n")
print(If(b) - If(a))