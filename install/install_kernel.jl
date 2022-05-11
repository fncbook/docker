import Pkg

println("Installing needed Julia packages...")
Pkg.add("Conda")
Pkg.add("IJulia")
Pkg.add("JSON")
Pkg.build("IJulia")
println("...done Julia install.")

println("\nInstalling Conda packages...")
using Conda
Conda.pip_interop(true)
Conda.pip("install","dockernel")
println("...done Conda.")

println("\nPulling docker image (large)...")
run(`docker pull tobydriscoll/fnc-julia`)
using JSON 
info = JSON.parse(read(`docker inspect tobydriscoll/fnc-julia`,String))
kerneldir = info[1]["ContainerConfig"]["Hostname"]
println("...done pull.")

println("\nInstalling Jupyter kernel...")
using IJulia
kernelloc = joinpath(IJulia.kerneldir(),kerneldir)
rm(kernelloc,force=true,recursive=true)
dockernel = joinpath(Conda.bin_dir(Conda.ROOTENV),"dockernel")
run(`$dockernel install fnc-julia --name "Julia for FNC" --language julia`)
logo32 = download("https://raw.githubusercontent.com/fncbook/docker/main/install/logo-32x32.png")
cp(logo32,joinpath(kernelloc,"logo-32x32.png"),force=true)
logo64 = download("https://raw.githubusercontent.com/fncbook/docker/main/install/logo-64x64.png")
cp(logo64,joinpath(kernelloc,"logo-64x64.png"),force=true)
println("...done.")

println("""\n\n
You do not need to run this file in the future.
To run the FNC kernel, do the following:

    1. Ensure that Docker is running (can be set to start automatically on login).
    2. Start Julia.
    3. Enter `using IJulia; jupyterlab()`. This should launch a page in your web browser.
    4. In the browser, either load an existing notebook or use the Launcher tab to start "Julia for FNC".

If you know how to run Jupyter some other way, you can do that instead of steps 2-3.
""")