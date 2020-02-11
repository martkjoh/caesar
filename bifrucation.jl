using Plots
default(show = true)

function f(x, r)
    return r * x * (1 - x)
end

n = 2000
m = 200
rs = LinRange(2.9, 4, n)
xs = Array{Float64}(undef, n, m)
ys = Array{Float64}(undef, n, m)
for i in 1:n
    r = rs[i]
    x = 0.5
    for j in 1:20
        x = f(x, r)
    end
    for j in 1:m
        x = f(x, r)
        xs[i, j] = x
        ys[i, j] = r
    end
    if mod(i*10, n) == 0
        print(i*100 / n, "\n")
    end
end

xs = reshape(xs, n * m, 1)
ys = reshape(ys, n * m, 1)

plt = scatter(ys, xs,
    marker = (:none, 2, 0.3, :black, stroke(0, :black)),
    size = (1200, 600)
    )

savefig(plt, "hi.pdf")

# return plt