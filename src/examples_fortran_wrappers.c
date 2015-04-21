#include <R.h>
#include <Rinternals.h>


// F77
void f77hlo_();

SEXP f77_hello_wrap()
{
  f77hlo_();
  
  return R_NilValue;
}



void f77sum_(double *x, int *xlen, double *sum);

SEXP f77_sum_wrap(SEXP x)
{
  int len = LENGTH(x);
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, 1));
  
  f77sum_(REAL(x), &len, REAL(ret));
  
  UNPROTECT(1);
  return ret;
}


// Fortran 2003

void f90_hello();

SEXP f90_hello_wrap()
{
  f90_hello();
  
  return R_NilValue;
}



double f90_sum(double *x, int xlen);

SEXP f90_sum_wrap(SEXP x)
{
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, 1));
  
  REAL(ret)[0] = f90_sum(REAL(x), LENGTH(x));
  
  UNPROTECT(1);
  return ret;
}
