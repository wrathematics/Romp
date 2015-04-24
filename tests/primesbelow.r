library(Romp)

n <- 20000

truth <- 2262
c <- c_primesbelow(n)
f77 <- f77_primesbelow(n)
f90 <- f90_primesbelow(n)
rcpp <- rcpp_primesbelow(n)

stopifnot(all.equal(truth, c))
stopifnot(all.equal(truth, f77))
stopifnot(all.equal(truth, f90))
stopifnot(all.equal(truth, rcpp))

