using Plots

x = 1:12
y = x.^3
plt = plot(x, y, lw = 3, size = (400, 300))

display(plt)
