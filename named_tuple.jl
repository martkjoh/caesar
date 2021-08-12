n = 10
a = (; (Symbol(i) => [j for j in 1:i:(i*n)] for i in 1:n)...)

# a[1] = a[1]*2   # Fungerer ikke
a[1] .= a[1]*2  # Fungerer

