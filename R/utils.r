#' Number of Processors
#' 
#' Returns the total number of physical+logical processors, as
#' detected by omp_get_max_threads().  Will  probably agree with 
#' \code{parallel::detectCores()}.
#' 
#' @export
num.procs <- function() .Call("R_num_procs", PACKAGE="Romp")

