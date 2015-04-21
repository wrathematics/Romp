#include <R.h>
#include <Rinternals.h>
#include <omp.h>


SEXP R_num_procs()
{
  SEXP ret;
  PROTECT(ret = allocVector(INTSXP, 1));
  
  INTEGER(ret)[0] = omp_get_num_procs();
  
  UNPROTECT(1);
  return ret;
}
