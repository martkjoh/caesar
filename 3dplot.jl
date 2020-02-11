using Plots

f(x, y) = sin(sqrt(x^2 + y^2)) / sqrt(x^2 + y^2)

a = 10
x = LinRange(-a, a, 100)
y = LinRange(-a, a, 100)

plt = surface(x, y, f)
surface!(show = true)