import numpy as np
from numpy import pi, exp
from matplotlib import pyplot as plt
import time 

def trapeziod(f, n, a, b):
    x = np.linspace(a, b, n + 1)
    fx = f(x)
    return np.sum((fx[:-1] + fx[1:])) / 2 * (b - a) / n

# Returns array with fourier coeff for freq j at index n + j,
# i.e. f(x) ~ sum_j=n^-n c[n+j]e^(i2pi * j x/(b - a)) 
def DFT(f, n, a, b):
    k = -2j*pi/(b - a) * np.linspace(-n, n, 2*n + 1, dtype = np.complex64)
    x = np.linspace(a, b, n, dtype = np.complex64)
    fx = f(x)
    return exp(np.outer(k, x)) @ fx / n

def f(x):
    return x**3 + x**2 - x 

a = -2
b = 3
n = range(100, 5000, 100)
t = np.empty(len(n))
for i in range(len(n)):
    t[i] = time.time()
    c = DFT(f, n[i], a, b)
    t[i] = time.time() - t[i]

plt.plot(n, t)
plt.savefig("t(n)_DFT_Python.png")