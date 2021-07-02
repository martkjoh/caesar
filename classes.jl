abstract type parent end

struct child <: parent 
    property
end

struct sibling <: parent
    property
end

function func(a)
    print("generic")
end

function func(a::parent)
    print("parent")
end

function func(a::child)
    print("child")
end


a = child(1)
func(a)
b = sibling(1)
func(b)