#create a spiked covariace (similar to og simulations)
make_spiked_cov <- function(d = 200, num_big = 10, big = 50, small = 1) {
  diag(c(rep(big, num_big), rep(small, d - num_big)))
}

#simulate BRCA-like data with 4 subtypes from paper
simulate_brca_like <- function(n_per = 40, d = 200) {
  Sigma <- make_spiked_cov(d)
  
  mu_LumA  <- rep(0, d)
  mu_LumB  <- c(rep(0.3, 5), rep(0, d - 5))
  mu_Her2  <- c(rep(0.9, 5), rep(0, d - 5))
  mu_Basal <- c(rep(2.0, 5), rep(0, d - 5))
  
  X_LumA  <- mvrnorm(n_per, mu_LumA,  Sigma)
  X_LumB  <- mvrnorm(n_per, mu_LumB,  Sigma)
  X_Basal <- mvrnorm(n_per, mu_Basal, Sigma)
  X_Her2  <- mvrnorm(n_per, mu_Her2,  Sigma)
  
  X <- rbind(X_LumA, X_LumB, X_Basal, X_Her2)
  subtype <- factor(rep(c("LumA", "LumB", "Basal", "Her2"), each = n_per))
  
  list(X = X, subtype = subtype)
}

brca_sim <- simulate_brca_like()
X_brca <- brca_sim$X
subtype <- brca_sim$subtype


#helper function for one sig pair
run_sigclust_pair <- function(X, subtype, pair, nsim = 200) {
  idx <- subtype %in% pair
  X_pair <- X[idx, ]
  labels_pair <- droplevels(subtype[idx])
  
  out <- sigclust(
    x       = X_pair,
    lab     = labels_pair,
    labflag = 1,
    nsim    = nsim
  )
  
  data.frame(
    subtype1 = pair[1],
    subtype2 = pair[2],
    pval     = out@pval
  )
}

#list out all subtype pairs
pairs_list <- list(
  c("Basal", "LumA"),
  c("Basal", "LumB"),
  c("Basal", "Her2"),
  c("LumA",  "LumB"),
  c("Her2",  "LumB"),
  c("Her2",  "LumA")
)

#run sigclust on above pair (makes easier)
brca_results <- do.call(rbind,
                        lapply(pairs_list, function(p) run_sigclust_pair(X_brca, subtype, p))
)

#format pvals for display
brca_results$pval_display <- ifelse(brca_results$pval == 0, "< 1e-4", brca_results$pval)

#print
brca_results