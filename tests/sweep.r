library(Romp)

m <- 100
n <- 10

x <- matrix(rnorm(m*n), m, n)
vec <- rnorm(m)

R <- sweep(x, STATS=vec, FUN="-", MARGIN=1)
C <- c_sweep(x, vec)
F90 <- f90_sweep(x, vec)
Rcpp <- rcpp_sweep(x, vec)

stopifnot(all.equal(R, C))
stopifnot(all.equal(R, F90))
stopifnot(all.equal(R, Rcpp))
