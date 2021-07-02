using Plots

a = 10
b = 1
V0 = 1

k(n) = n * pi / a
C(n) = V0 * (1 - (-1)^n) / cosh(k(n) * b)
V(n, x, y) = C(n) * cosh(k(n) * x) * sin(k(n) * y)


x = LinRange(-b, b, 100)
y = LinRange(0, a, 100)
print("heeeei\n")
N = 5

for n in 1:N
    n = 2n + 1
    surface(x, y, (x, y) -> V(n, x, y))
    surface!(xlims = [-b, b])
    surface!(ylims = [0, a])
    surface!(zlims = [-4*V0, 4*V0])
    surface!(show = true)
    print(n, "\n")
    
    sleep(1)

end
