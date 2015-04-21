#include <omp.h>
#include <R.h>
#include <Rinternals.h>


SEXP c_hello()
{
  int tid, nthreads;
  
  #pragma omp parallel private(tid)
  {
    nthreads = omp_get_num_threads();
    tid = omp_get_thread_num();
    
    Rprintf("Hello from thread %d of %d\n", tid, nthreads);
  }
  
  return R_NilValue;
}



SEXP c_sum(SEXP x)
{
  SEXP ret;
  double sum = 0;
  double *ptx = REAL(x);
  
  #pragma omp parallel for default(shared) reduction(+:sum)
  for (int i=0; i<LENGTH(x); i++)
    sum += *(ptx+i);
  
  PROTECT(ret = allocVector(REALSXP, 1));
  REAL(ret)[0] = sum;
  UNPROTECT(1);
  return ret;
}



SEXP c_sweep(SEXP x, SEXP vec)
{
  const int m = nrows(x), n = ncols(x);
  SEXP ret;
  PROTECT(ret = allocMatrix(REALSXP, m, n));
  double *ptx = REAL(x), *ptvec = REAL(vec), *ptret = REAL(ret);
  
  #pragma omp parallel for default(shared)
  for (int j=0; j<n; j++)
  {
    for (int i=0; i<m; i++)
      *(ptret + (i + m*j)) = *(ptx + (i + m*j)) - *(ptvec + i);
  }
  
  UNPROTECT(1);
  return ret;
}

