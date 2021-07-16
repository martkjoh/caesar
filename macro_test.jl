using ExprTools

macro print(ex)
    print(ex)
end

# @print 1

macro new_f(ex)
    """ Creates new function f(x, y) = f(x) """
    def = splitdef(ex)
    def2 = deepcopy(def)
    push!(def2[:args], :y)
    ex2 = combinedef(def2)
    quote
        $ex2
    end |>esc
end

@new_f(
function f(x)
    return x
end
)