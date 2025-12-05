###################### REPEATED SIMULATION SCENARIOS ######################

#v = 50
run_null_once <- function(icovest = 1, nsim = 1000) {
  X <- r_gauss(n, rep(0, p), Sigma)
  sc <- sigclust(X, nsim = nsim, nrep = 1, labflag = 0, icovest = icovest)
  sc@pval                       # extract p-value
}

run_alt1_once <- function(a = 30, icovest = 1, nsim = 1000) {
  mu1 <- rep(0, p)
  mu2 <- c(a, rep(0, p - 1))
  
  X1 <- r_gauss(n/2, mu1, Sigma)
  X2 <- r_gauss(n/2, mu2, Sigma)
  
  sc <- sigclust(rbind(X1, X2), nsim = nsim, nrep = 1, labflag = 0, icovest = icovest)
  sc@pval
}

run_alt2_once <- function(a = 0.5, icovest = 1, nsim = 1000) {
  mu1 <- rep(0, p)
  mu2 <- rep(a, p)
  
  X1 <- r_gauss(n/2, mu1, Sigma)
  X2 <- r_gauss(n/2, mu2, Sigma)
  
  sc <- sigclust(rbind(X1, X2), nsim = nsim, nrep = 1, labflag = 0, icovest = icovest)
  sc@pval
}

set.seed(293)

null_pvals  <- replicate(100, run_null_once())
alt1_pvals  <- replicate(100, run_alt1_once())
alt2_pvals  <- replicate(100, run_alt2_once())

prop_null_sig <- mean(null_pvals < 0.05)
prop_alt1_sig <- mean(alt1_pvals < 0.05)
prop_alt2_sig <- mean(alt2_pvals < 0.05)


results <- data.frame(
  Scenario = c("Null", "Alt 1 (strong shift)", "Alt 2 (weak dense shift)"),
  NumRuns  = c(100, 100, 100),
  Prop_p_less_0.05 = c(prop_null_sig, prop_alt1_sig, prop_alt2_sig)
)


###########################################

#V = 30
make_sigma <- function(p, v, w) {
  diag(c(rep(v, w), rep(1, p - w)))
}

p  <- 1000
v  <- 30
w  <- 10
n  <- 100
Sigma <- make_sigma(p, v, w)

r_gauss <- function(n, mu, Sigma) {
  MASS::mvrnorm(n, mu, Sigma)
}

set.seed(293)

null_pvals_30  <- replicate(100, run_null_once())
alt1_pvals_30  <- replicate(100, run_alt1_once())
alt2_pvals_30 <- replicate(100, run_alt2_once())

prop_null_sig_30 <- mean(null_pvals_30 < 0.05)
prop_alt1_sig_30 <- mean(alt1_pvals_30 < 0.05)
prop_alt2_sig_30 <- mean(alt2_pvals_30 < 0.05)


results_30 <- data.frame(
  Scenario = c("Null", "Alt 1 (strong shift)", "Alt 2 (weak dense shift)"),
  NumRuns  = c(100, 100, 100),
  Prop_p_less_0.05 = c(prop_null_sig_30, prop_alt1_sig_30, prop_alt2_sig_30)
)