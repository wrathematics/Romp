library(Romp)
library(rbenchmark)

cols <- c("test", "replications", "elapsed", "relative")

x <- rnorm(2.5e7)
benchmark(sum(x), c_sum(x), rcpp_sum(x), f77_sum(x), f90_sum(x), columns=cols, order="relative")

