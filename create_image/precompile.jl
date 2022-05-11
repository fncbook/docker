ENV["GKSwstype"]="nul"  # avoids connection of GR to X server
using FundamentalsNumericalComputation
savefig(plot(rand(10),show=false),"foo.png")
solve( ODEProblem((u,p,t)->u,1.,(0.,1.)) )