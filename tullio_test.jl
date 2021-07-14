using Tullio

 a = LinRange(0, 1, 10)
 @tullio b[i] := 1 + a[i]^2

 print(b)

 function f(x)
    return exp(-x^2/2)
 end

 @tullio b[i] = f(a[i])
 