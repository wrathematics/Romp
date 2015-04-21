library(Romp)

x <- rnorm(100)

R <- sum(x)
c <- c_sum(x)
f77 <- f77_sum(x)
f90 <- f90_sum(x)
rcpp <- rcpp_sum(x)

stopifnot(all.equal(R, c))
stopifnot(all.equal(R, f77))
stopifnot(all.equal(R, f90))
stopifnot(all.equal(R, rcpp))

