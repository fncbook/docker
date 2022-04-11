using IJulia
IJ = replace(pathof(IJulia),"IJulia.jl"=>"kernel.jl")
lines = readlines("/root/.local/share/jupyter/kernels/julia-FNC/kernel.json")
i = findfirst(contains("IJulia"),lines)
lines[i] = replace(lines[i],r"\".+\""=>"\"$IJ\"")
open("/root/.local/share/jupyter/kernels/julia-FNC/kernel.json","w") do io
    println.(Ref(io),lines)
end
