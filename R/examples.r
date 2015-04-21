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

#' @export
c_sweep <- function(x, vec)
{
  if (!is.double(x))
    storage.mode(x) <- "double"
  if (!is.double(vec))
    storage.mode(vec) <- "double"
  
  if (length(vec) != nrow(x))
    stop("invalid vec length")
  
  .Call("c_sweep", x, vec, PACKAGE="Romp")
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

#' @export
f90_sweep <- function(x, vec)
{
  if (length(vec) != nrow(x))
    stop("invalid vec length")
  
  .Call("f90_sweep_wrap", x, vec, PACKAGE="Romp")
}



### Rcpp

#' @export
rcpp_hello <- rcpp_hello_

#' @export
rcpp_sum <- rcpp_sum_

#' @export
rcpp_sweep <- function(x, vec)
{
  if (length(vec) != nrow(x))
    stop("invalid vec length")
  
  rcpp_sweep_(x, vec)
}
