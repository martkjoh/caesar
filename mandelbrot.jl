using Plots

function f(z, c)
    return z^2 + c
end

imRange = 2
realRange = 2
n = 5000
m = 100

x = LinRange(-2, 1, n)
y = LinRange(-1, 1, n)
z = Array{BigFloat}(undef, n, n)

for i in 1:n
    for j in 1:n
        c = complex(x[i], y[j])
        z0 = 0
        k = 0
        while true
            z0 = f(z0, c)
            k += 1
            if abs(z0) > 2 || k > m
                break
            end
        end
        z[j, i] = m - k
    end
    if mod(i*10, n) == 0
        print(i*100 / n, "\n")
    end
end

plt = heatmap(x, y, z)

print("saving...\n")

savefig(plt, "ha2.pdf")
