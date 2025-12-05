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

##################################################

#creating table to showcase all p-values of 3 scenarios at different v values
results_50 <- results

results_30$V <- 30
results_50$V <- 50

results_combined <- rbind(results_30, results_50)

results_combined_pretty <- results_combined
names(results_combined_pretty) <- c(
  "Scenario",
  "Number of Runs",
  "Proportion p < 0.05",
  "Spike Variance v"
)

knitr::kable(
  results_combined_pretty,
  caption = "Proportion of SigClust p-values below 0.05 across scenarios and spike variance v."
)


##################################################

#creating the histograms of the 3 scenarios 
#v = 50
df_null_v50 <- data.frame(pval = null_pvals)
df_alt1_v50 <- data.frame(pval = alt1_pvals)
df_alt2_v50 <- data.frame(pval = alt2_pvals)



null_50 <- ggplot(df_null_v50, aes(x = pval)) +
  geom_histogram(
    bins = 10,
    color = "white",
    fill  = "deeppink1"
  ) +
  scale_x_continuous(
    limits = c(0, 1),
    breaks = seq(0, 1, by = 0.1)
  ) +
  labs(
    title = "Null p-values (v = 50)",
    x = "p-value",
    y = "Frequency"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.2, face = "bold")
  )

alt1_50 <- ggplot(df_alt1_v50, aes(x = pval)) +
  geom_histogram(
    bins = 10,
    color = "white",
    fill  = "lightslateblue"
  ) +
  scale_x_continuous(
    limits = c(0, 0.1),
    breaks = seq(0, 1, by = 0.01)
  ) +
  labs(
    title = "Alt 1 p-values (v = 50)",
    x = "p-value",
    y = "Frequency"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.2, face = "bold")
  )

alt2_50 <- ggplot(df_alt2_v50, aes(x = pval)) +
  geom_histogram(
    bins = 10,
    color = "white",
    fill  = "royalblue"
  ) +
  scale_x_continuous(
    limits = c(0, 0.1),
    breaks = seq(0, 1, by = 0.01)
  ) +
  labs(
    title = "Alt 2 p-values (v = 50)",
    x = "p-value",
    y = "Frequency"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.2, face = "bold")
  )

grid.arrange(null_50, alt1_50,alt2_50, nrow = 3)


##################################################

#creating the histograms of the 3 scenarios 
#v = 50
df_null_v_30 <- data.frame(pval = null_pvals_30)
df_alt1_v_30 <- data.frame(pval = alt1_pvals_30)
df_alt2_v_30 <- data.frame(pval = alt2_pvals_30)


null_30 <- ggplot(df_null_v_30, aes(x = pval)) +
  geom_histogram(
    bins = 10,
    color = "white",
    fill  = "deeppink1"
  ) +
  scale_x_continuous(
    limits = c(0, 1),
    breaks = seq(0, 1, by = 0.1)
  ) +
  labs(
    title = "Null p-values (v = 30)",
    x = "p-value",
    y = "Frequency"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.2, face = "bold")
  )

alt1_30 <- ggplot(df_alt1_v_30, aes(x = pval)) +
  geom_histogram(
    bins = 10,
    color = "white",
    fill  = "lightslateblue"
  ) +
  scale_x_continuous(
    limits = c(0, 0.01),
    breaks = seq(0, 1, by = 0.001)
  ) +
  labs(
    title = "Alt 1 p-values (v = 30)",
    x = "p-value",
    y = "Frequency"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.2, face = "bold")
  )

alt2_30 <- ggplot(df_alt2_v_30, aes(x = pval)) +
  geom_histogram(
    bins = 10,
    color = "white",
    fill  = "royalblue"
  ) +
  scale_x_continuous(
    limits = c(0, 0.01),
    breaks = seq(0, 1, by = 0.001)
  ) +
  labs(
    title = "Alt 2 p-values (v = 30)",
    x = "p-value",
    y = "Frequency"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.2, face = "bold")
  )

grid.arrange(null_30, alt1_30,alt2_30, nrow = 3)