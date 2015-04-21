library(Romp)
library(rbenchmark)

m <- 50000
n <- 500

x <- matrix(rnorm(m*n), m, n)
vec <- rnorm(m)

r_sweep <- function(x, vec) sweep(x, STATS=vec, MARGIN=1, FUN="-")


cols <- c("test", "replications", "elapsed", "relative")

reps <- 100
benchmark(r_sweep(x, vec), c_sweep(x, vec), rcpp_sweep(x, vec), f77_sweep(x, vec), f90_sweep(x, vec), columns=cols, order="relative", replications=reps)

