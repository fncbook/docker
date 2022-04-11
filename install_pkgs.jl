import Pkg; 
Pkg.add("Conda"); 
Pkg.build("Conda"); 
using Conda
Conda.add("jupyterlab")
Pkg.add("IJulia"); Pkg.build("IJulia")
Pkg.add("PackageCompiler")
Pkg.add("Arpack");Pkg.precompile()  # not clear why this is necessary
Pkg.add(url="https://github.com/fncbook/FundamentalsNumericalComputation.jl")
Pkg.precompile()
