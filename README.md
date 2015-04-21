# Romp

Basic examples using OpenMP with R, for C, C++, F77, and Fortran 2003.


## Examples

There are 3 examples, using each of C, C++ (Rcpp), F77, and F2003.

#### Hello World

A basic OpenMP hello world.  Note that the order of thread printing
is not guaranteed.

#### Sum

Sums up a numeric vector.

#### Sweep

Sweeps a numeric vector from a numeric matrix of the same length
as the number of rows of that matrix.  Equivalent to calling
`sweep(x, STATS=vec, MARGIN=1, FUN="-")` in R.


## Benchmarks

I wouldn't take the numbers here too seriously, especially for the
sum example, where they appear to be statistically identical.
The languages separate on the sweep example, though possibly for
implementation reasons.

The benchmarks are located at `Romp/inst/benchmarks/` of the source
tree.  All tests were performed using:

* R 3.2.0
* gcc 4.9.1
* 4 cores of a Core i5-2500K CPU @ 3.30GHz


#### Sum

```
         test replications elapsed relative
5  f90_sum(x)          100   1.178    1.000
4  f77_sum(x)          100   1.179    1.001
2    c_sum(x)          100   1.186    1.007
3 rcpp_sum(x)          100   1.196    1.015
1      sum(x)          100   2.605    2.211
```

#### Sweep

```
                test replications elapsed relative
4  f77_sweep(x, vec)          100   5.242    1.000
5  f90_sweep(x, vec)          100   5.315    1.014
2    c_sweep(x, vec)          100   5.354    1.021
3 rcpp_sweep(x, vec)          100  14.966    2.855
1    r_sweep(x, vec)          100  52.330    9.983
```



## Integration with R

If you are unfamiliar with integrating C, C++, or Fortran into R,
then the following will hopefully be of use to you.


#### C

We use the `.Call()` interface.  There is a (nearly) deprecated
`.C()` interface, which you should not use, as it has serious
performance loss compared to the `.Call()` interface.

If you are interested in some simplifications of R's C interface
but don't want to jump to C++, you might consider taking a look
at [RNACI](https://github.com/wrathematics/RNACI).

#### C++

Here we use [Rcpp](http://rcpp.org/).  Using RcppAttributes (noted
by the `// [[Rcpp::export]]` calls), we can write something that
looks very much like C++, and use Rcpp's (R function)
`compileAttributes()` to generate C-level and R-level R wrappers.
The script `Romp/resrc` does this.

#### Fortran

For both F77 and F90+, integration with R is non-trivial.  As with C,
there is a (nearly) deprecated interface `.Fortran()` which you should
not use due to its large performance overhead.  Instead, you should:

1. Write your Fortran code.
2. Write a C wrapper of the Fortran code using R's `.Call()` interface (or Rcpp if you prefer).
3. Call the C code from R using `.Call(()`.

As noted, you can use Rcpp in lieu of R's basic C interface for
wrapping Fortran code, though I seriously recommend against it.
Bringing in C++ can complicate linking, among other things, and
for wrapping C/Fortran code, in my opinion, Rcpp brings little to
the table (C++ is another story!).  If you are interested in some
simplifications of R's C interface but don't want to jump to use
Rcpp, you might consider taking a look at
[RNACI](https://github.com/wrathematics/RNACI).

It is difficult to reliably use F90+ functions and subroutines which
live in modules without the use of the F2003 `iso_c_binding` module
(which has been supported by every compiler for ages).  This package
gives some nice examples of how to use module code.

A final note about F90+ in particular, is that much of the advice
in Writing R Extensions ranges from terrible to wildly inaccurate.
Ignore what they have to say.

