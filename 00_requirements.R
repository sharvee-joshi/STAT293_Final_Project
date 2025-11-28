#load in required packages needed for project
library(MASS) #creating helper function of sigma
library(sigclust) #main function of project
library(ggplot2) #visuals



#seed used throughout project
set.seed(293)


#helper function used to generate sigma
make_sigma <- function(p, v, w) {
  diag(c(rep(v, w), rep(1, p - w)))
}