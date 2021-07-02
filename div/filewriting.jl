dir = "filewriting/"
file = open(dir * "test.txt", "w")
write(file, "dette er en test" )
close(file)


using DelimitedFiles
x = 1:20
y = -(1:20)
filename = dir * "array.csv"
file = open(filename, "w")
writedlm(file, [x, y], ",")
close(file)

a = readdlm(filename, ',', Int, '\n')
b = a[1, :]
print(b)
