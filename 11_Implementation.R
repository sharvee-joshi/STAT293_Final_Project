#implementation of null hypothesis
sigclust_null <- function(nsim = 1000, nrep = 1, icovest = 1) {
  mu0 <- rep(0, p)
  X   <- mvrnorm(n, mu0, Sigma)
  
  sc <- sigclust(
    x       = X,
    nsim    = nsim,
    nrep    = nrep,
    labflag = 0,
    icovest = icovest # 1 = soft, 2 = sample, 3 = hard
  )
  plot(sc)                            # classic "SigClust Results" figure
  mtext("Null: one Gaussian", side = 3, line = 0.5)
  invisible(sc)  
}

sc_null <- sigclust_null()
plot(sc_null)

#implementation alt 1 hypothesis 
sigclust_alt1 <- function(a = 30, nsim = 1000, nrep = 1, icovest = 1) {
  mu1 <- rep(0, p)
  mu2 <- c(a, rep(0, p - 1))   # shift only in first coord
  
  X1 <- mvrnorm(n/2, mu1, Sigma)
  X2 <- mvrnorm(n/2, mu2, Sigma)
  X  <- rbind(X1, X2)
  
  sc <- sigclust(
    x       = X,
    nsim    = nsim,
    nrep    = nrep,
    labflag = 0,      # still let SigClust pick clusters
    icovest = icovest
  )
  
  plot(sc)
  mtext(paste0("Alt 1: one-direction signal (a = ", a, ")"),
        side = 3, line = 0.5)
  invisible(sc)
}

sc_alt1 <- sigclust_alt1(a = 30)



#implementation al2 hypothesis
sigclust_alt2 <- function(a = 0.5, nsim = 1000, nrep = 1, icovest = 1) {
  mu1 <- rep(0, p)
  mu2 <- rep(a, p)            # small shift in every coordinate
  
  X1 <- mvrnorm(n/2, mu1, Sigma)
  X2 <- mvrnorm(n/2, mu2, Sigma)
  X  <- rbind(X1, X2)
  
  sc <- sigclust(
    x       = X,
    nsim    = nsim,
    nrep    = nrep,
    labflag = 0,      # again, SigClust does its own k-means
    icovest = icovest
  )
  
  plot(sc)
  mtext(paste0("Alt 2: dense weak signal (a = ", a, ")"),
        side = 3, line = 0.5)
  invisible(sc)
}

sc_alt2 <- sigclust_alt2(a = 0.5)