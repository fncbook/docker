import Pkg; 
Pkg.add("Conda"); 
Pkg.build("Conda"); 
using Conda
Conda.add("jupyterlab")
Pkg.add("IJulia"); Pkg.build("IJulia")
Pkg.add("PackageCompiler")
Pkg.add("Arpack");Pkg.precompile()  # not clear why this is necessary
Pkg.add("FundamentalsNumericalComputation")
Pkg.precompile()

using PackageCompiler; 
create_sysimage([:FundamentalsNumericalComputation],sysimage_path="/root/build/julia_fast.so",precompile_execution_file="/root/build/precompile.jl")