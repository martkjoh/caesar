using Random

n = 100
m = 1_000_000

@time a = Dict(i => [j for j in 1:i:i*m] for i in 1:n);
@time b = (; (Symbol(i) => [j for j in 1:i:i*m] for i in 1:n)...);

indx1 = shuffle(1:m)
indx2 = shuffle(1:m)

function double_shuffle!(a, indx)
    for i in 1:n
        for j in indx
            a[i][j] = a[i][j] * 2
        end
    end
end

double_shuffle!(a, indx1)
double_shuffle!(b, indx2)

@time double_shuffle!(a, indx1)
@time double_shuffle!(b, indx2)
