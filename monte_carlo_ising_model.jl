using Random
using Plots
using DelimitedFiles

# Utillities
# Small functions needed throught the program

function get_s(N)
    return rand!(Array{Int}(undef, (N, N)), [-1, 1])
end

function indxShft(i, n, N)
    """ Shift indexes with n steps, subject to peridic boundaries """
    return mod(i-1+n, N) + 1    # Fucking 1-indexation should be illegal
end

function sum_neigh(s, i, j, N)
    return (
        s[indxShft(i, -1, N), j] 
        + s[indxShft(i, +1, N), j] 
        + s[i, indxShft(j, -1, N)] 
        + s[i, indxShft(j, +1, N)]
    )
end


# Physics

Tc = 2.26

function get_delta_H(s, i, j, N)
    return 2*s[i, j] * sum_neigh(s, i, j, N)
end

function energy(s, N)
    E = 0
    for i in 1:N
        for j in 1:N
            E += -1/2 * s[i, j] * sum_neigh(s, i, j, N)
        end
    end
    return E/N^2
end

function abs_mag(s, N)
    return abs(sum(s)) / N^2
end

# Monte Carlo simulation


function MC_sweep!(s, N, T)
    for _ in 1:N^2
        i, j = rand(1:N, 2)
        delta_H = get_delta_H(s, i, j, N)
        if delta_H < 0
            s[i, j] *= -1
            continue
        end
        if exp(-delta_H/T) > rand()
            s[i, j] *= -1
        end
    end
end


function get_samples(N, T, n, equib)
    s = get_s(N)
    M = E = M2 = E2 = 0
    for i in 1:equib
        MC_sweep!(s, N, T)
    end
    for i in 1:n
        MC_sweep!(s, N, T)
        Ei = energy(s, N)
        Mi = abs_mag(s, N)
        E += Ei
        E2 += Ei^2
        M += Mi
        M2 += Mi^2
    end
    return [E, E2, M, M2] / n
end


function write_data(data, num_quant, names, dir)
    for i in 1:num_quant
        path = dir * names[i] * ".csv"
        file = open(path, "w")
        writedlm(file, data[i, :, :], ",")
        close(file)
    end
end

function read_data(num_quant, sizes, temps, names, dir)
    data  = Array{Float64}(undef, (num_quant, sizes, temps))
    for i in 1:num_quant
        path = dir * names[i] * ".csv"
        data[i, :, :] = readdlm(path, ',', Float64, '\n')
    end
    return data
end

function plot_equibliration()
    N = 100
    num_sweeps = 5000
    s = get_s(N)
    frames = 50
    heatmap(1:N, 1:N, s)
    heatmap!(show=true)

    T = 0.01
    for i in 1:num_sweeps
        MC_sweep!(s, N, T)
        if i%frames==1
            heatmap(1:N, 1:N, s)
            heatmap!(show=true)
        end
    end
end


function main()
    equib = 10_000
    n = 1_000
    dir = "ising-mod-data/"

    # number of different tempratures to simulate
    temps = 10
    Ts = LinRange(1.5, 1.5*Tc, temps)
    # The different sizes of the grid to simutale
    Ns = [8, 16, 32, 64]
    sizes, = size(Ns)

    names = ["energy", "energy_squared", "abs_mag", "abs_mag_squared"]
    num_quant, = size(names)

    function sample_observables()
        data  = Array{Float64}(undef, (num_quant, sizes, temps))
        steps = sizes * temps
        for i in eachindex(Ns)
            for j in eachindex(Ts)
                N = Ns[i]; T = Ts[j]
                data[:, i, j] = get_samples(N, T, n, equib)

                print(ceil(((i-1)*temps+j)/steps * 100), "%\n")
            end
        end    
        write_data(data, num_quant, names, dir)
    end

    function plot_observables()
        data = read_data(num_quant, sizes, temps, names, dir)

        for i in eachindex(names)
            p = plot()
            for j in eachindex(Ns)
                plot!(Ts, data[i, j, :], marker=:dot, label=string(Ns[j]))
            end
            plot!(title=names[i])
            savefig(dir * names[i] * ".png")
        end
    end

    # sample_observables()
    plot_observables()
end



main()