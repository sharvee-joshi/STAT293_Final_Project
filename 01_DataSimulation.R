#simulate data needed for all simulation scenarios
#specficially Implementation section of paper 
p  <- 1000
v  <- 50       # large eigenvalue
w  <- 10       # number of large eigenvalues
n  <- 100      # total sample size
Sigma <- make_sigma(p, v, w)

