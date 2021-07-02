function manipulate(a)
    a[2] = 4.3
end

function main()
    a = zeros(10)
    manipulate(a)
    print(a)
end

main()
