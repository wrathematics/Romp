#' OpenMP Examples
#' 
#' There are 3 examples, each using OpenMP, across 4 implementations:
#' C, C++, F77, and F2003.
#' 
#' The \code{_hello()} functions are simple hello worlds.  Note that
#' the order of printing by the threads is not guaranteed.
#' 
#' The \code{_sum()} functions sum up a numeric vector.
#' 
#' The \code{_sweep()} functions sweep a numeric vector from a
#' numeric matrix, provided the vector is exactly the length of
#' the number of columns of the matrix.  This is equivalent to a
#' special case of \code{sweep(x, STATS=vec, MARGIN=1, FUN="-")}.
#' 
#' @param x
#' A numeric vector for the sum example, and a numeric matrix for
#' the sweep example.
#' @param vec
#' A numeric vector the same length as the number of rows as x.
#' 
#' @name ompexamples
#' @rdname ompexamples
NULL


### C

#' @rdname ompexamples
#' @export
c_hello <- function() invisible(.Call("c_hello", PACKAGE="Romp"))

#' @rdname ompexamples
#' @export
c_sum <- function(x)
{
  if (!is.double(x))
    storage.mode(x) <- "double"
  
  .Call("c_sum", x, PACKAGE="Romp")
}

#' @rdname ompexamples
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

#' @rdname ompexamples
#' @export
f77_hello <- function() invisible(.Call("f77_hello_wrap", PACKAGE="Romp"))

#' @rdname ompexamples
#' @export
f77_sum <- function(x)
{
  if (!is.double(x))
    storage.mode(x) <- "double"
  
  .Call("f77_sum_wrap", x, PACKAGE="Romp")
}

#' @rdname ompexamples
#' @export
f77_sweep <- function(x, vec)
{
  if (length(vec) != nrow(x))
    stop("invalid vec length")
  
  .Call("f77_sweep_wrap", x, vec, PACKAGE="Romp")
}

#' @rdname ompexamples
#' @export
f90_hello <- function() invisible(.Call("f90_hello_wrap", PACKAGE="Romp"))

#' @rdname ompexamples
#' @export
f90_sum <- function(x)
{
  if (!is.double(x))
    storage.mode(x) <- "double"
  
  .Call("f90_sum_wrap", x, PACKAGE="Romp")
}

#' @rdname ompexamples
#' @export
f90_sweep <- function(x, vec)
{
  if (length(vec) != nrow(x))
    stop("invalid vec length")
  
  .Call("f90_sweep_wrap", x, vec, PACKAGE="Romp")
}



### Rcpp

#' @rdname ompexamples
#' @export
rcpp_hello <- rcpp_hello_

#' @rdname ompexamples
#' @export
rcpp_sum <- rcpp_sum_

#' @rdname ompexamples
#' @export
rcpp_sweep <- function(x, vec)
{
  if (length(vec) != nrow(x))
    stop("invalid vec length")
  
  rcpp_sweep_(x, vec)
}
