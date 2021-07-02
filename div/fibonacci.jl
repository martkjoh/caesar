function fib(n, x = 0, y = 1)
    if n == 0
        return x
    end
    z = y
    y = x + y
    x = z
    fib(n - 1, x, y)
end

print(fib(6))
