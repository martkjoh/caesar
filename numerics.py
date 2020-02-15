import numpy as np
from numpy import pi, exp
from matplotlib import pyplot as plt

def trapeziod(f, n, a, b):
    x = np.linspace(a, b, n + 1)
    fx = f(x)
    return np.sum((fx[:-1] + fx[1:])) / 2 * (b - a) / n

def DFT(f, n, a, b):
    k = (-2j * pi) *  np.linspace(-n, n, 2*n + 1)
    x = np.linspace(a, b, n) / (b - a)
    c = np.zeros(2*n + 1).astype(np.complex64)
    for i in range(2*n + 1):
        c[i] = exp(k[i] * x) @ f / n
    return c
    # return exp(np.outer(k, x)) @ f / n

def f(x):
    return x**3 + x**2 - x 

a = -4
b = 1
n = 1000
m = 10
x = np.linspace(a, b, n)

plt.plot(x, f(x))
c = DFT(f(x), n, a, b)

for i in range(10):
    s = c[n] * np.ones(n, dtype = np.complex64)
    for j in range(1, i):
        s += c[n - j] * exp(2j*pi*(-j) / (b - a) * x)
        s += c[n + j] * exp(2j*pi*j / (b - a) * x)
    print(c[n + i])

    plt.plot(x, f(x))
    plt.plot(x, s)
    plt.show()
