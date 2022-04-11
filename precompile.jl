using FundamentalsNumericalComputation
savefig(plot(rand(10)),"foo.png")
savefig(plot(rand(10)),"foo.svg")
solve( ODEProblem((u,p,t)->u,1.,(0.,1.)) )