#cluster td toy example code

sim_2d <- function(n = 200, a = 0) {
  #create the covariance, (make this simple for example case)
  Sigma2 <- diag(2)
  mu1 <- c(0, 0)
  mu2 <- c(a, 0)
  
  X1 <- MASS::mvrnorm(n/2, mu1, Sigma2)
  X2 <- MASS::mvrnorm(n/2, mu2, Sigma2)
  
  data.frame(
    x1 = c(X1[,1], X2[,1]),
    x2 = c(X1[,2], X2[,2]),
    true_cluster = factor(rep(c("Cluster 1", "Cluster 2"), each = n/2)),
    a = a
  )
}

#for ex. purposes, use ez a vals 
a_vals <- c(0, 1, 2, 4)
toy_df <- do.call(rbind, lapply(a_vals, function(a) sim_2d(a = a)))
toy_df$a <- factor(toy_df$a, levels = a_vals,
                   labels = paste0("a = ", a_vals))

#create ggplot (used gpt for this to make it prettier lol)
ggplot(toy_df, aes(x = x1, y = x2, color = true_cluster)) +
  geom_point(alpha = 0.6, size = 1.8) +
  facet_wrap(~ a, nrow = 1) +
  theme_minimal(base_size = 13) +
  scale_color_manual(
    values = c(
      "Cluster 1" = "deeppink1",  
      "Cluster 2" = "lightslateblue"   
    )
  ) +
  labs(
    title = "Toy 2D Example",
    color = "True cluster"
  )