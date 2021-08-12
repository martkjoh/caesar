using ForwardDiff
D = ForwardDiff.Dual

a = D{:b}(100, 2)
a^2