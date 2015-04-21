### C

#' @export
c_hello <- function() invisible(.Call("c_hello", PACKAGE="Romp"))

#' @export
c_sum <- function(x)
{
  if (!is.double(x))
    storage.mode(x) <- "double"
  
  .Call("c_sum", x, PACKAGE="Romp")
}



### Fortran

#' @export
f77_hello <- function() invisible(.Call("f77_hello_wrap", PACKAGE="Romp"))

#' @export
f77_sum <- function(x)
{
  if (!is.double(x))
    storage.mode(x) <- "double"
  
  .Call("f77_sum_wrap", x, PACKAGE="Romp")
}

#' @export
f90_hello <- function() invisible(.Call("f90_hello_wrap", PACKAGE="Romp"))

#' @export
f90_sum <- function(x)
{
  if (!is.double(x))
    storage.mode(x) <- "double"
  
  .Call("f90_sum_wrap", x, PACKAGE="Romp")
}



### Rcpp

#' @export
rcpp_hello <- rcpp_hello_

#' @export
rcpp_sum <- rcpp_sum_
