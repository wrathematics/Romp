# Romp

Basic examples using OpenMP with R, for C, C++, F77, and Fortran 2003.


## Structure

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

