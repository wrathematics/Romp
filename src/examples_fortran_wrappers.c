#include <R.h>
#include <Rinternals.h>


// F77
void f77hlo_();

SEXP f77_hello_wrap()
{
  f77hlo_();
  
  return R_NilValue;
}



void f77sum_(double *restrict x, int *restrict xlen, double *restrict sum);

SEXP f77_sum_wrap(SEXP x)
{
  int len = LENGTH(x);
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, 1));
  
  f77sum_(REAL(x), &len, REAL(ret));
  
  UNPROTECT(1);
  return ret;
}



void f77swp_(int *m, int *n, const double *restrict x, const double *vec, double *ret);

SEXP f77_sweep_wrap(SEXP x, SEXP vec)
{
  int m = nrows(x), n = ncols(x);
  SEXP ret;
  PROTECT(ret = allocMatrix(REALSXP, m, n));
  
  f77swp_(&m, &n, REAL(x), REAL(vec), REAL(ret));
  
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



double f90_sum(double *restrict x, int xlen);

SEXP f90_sum_wrap(SEXP x)
{
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, 1));
  
  REAL(ret)[0] = f90_sum(REAL(x), LENGTH(x));
  
  UNPROTECT(1);
  return ret;
}



void f90_sweep(const int m, const int n, const double *restrict x, const double *vec, double *ret);

SEXP f90_sweep_wrap(SEXP x, SEXP vec)
{
  const int m = nrows(x), n = ncols(x);
  SEXP ret;
  PROTECT(ret = allocMatrix(REALSXP, m, n));
  
  f90_sweep(m, n, REAL(x), REAL(vec), REAL(ret));
  
  UNPROTECT(1);
  return ret;
}
