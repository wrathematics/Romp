library(Romp)
library(rbenchmark)

n <- 50000


cols <- c("test", "replications", "elapsed", "relative")

reps <- 100
benchmark(c_primesbelow(n), f77_primesbelow(n), f90_primesbelow(n), rcpp_primesbelow(n), columns=cols, order="relative", replications=reps)

