BLAS/LAPACK Runtime Switch: User Guide
======================================

## Users Who Don't Care about it

They could just ignore the `eselect-ldso` USE flag and install things under the default settings.

## Users Who Want to Switch BLAS/LAPACK at Runtime

First the skeleton part needs to be installed:

```
USE=eselect-ldso emerge --ask >=virtual/blas-3.8 >=virtual/lapack-3.8
```

The above command will pull in the reference BLAS/LAPACK and the customized
eselect modules for BLAS and LAPACK. Now you should be able to list BLAS
or LAPACK candidates by issuing:

```
eselect blas list
eselect lapack list
```

Some candidates are avaialble in Gentoo's main repo, for example BLIS and
OpenBLAS. When they are installed with the `eselect-ldso` USE flag toggled,
the ebuild scripts will automatically register them in the mechanism. For
example:

```
USE=eselect-ldso emerge --ask >=sci-libs/blis-0.6.0
USE=eselect-ldso emerge --ask >=sci-libs/openblas-0.3.5
```

Note, nothing will be registered if you missed the `eselect-ldso` flag.
After installation, we could switch the libraries like so:

```
eselect blas set openblas
eselect blas set openblas
```

Here are some recommended combinations for your choice:

```
* blas=openblas  lapack=openblas
* blas=blis      lapack=reference
* blas=reference lapack=reference
```

Note the following combinations are discouraged:

```
* blas=blis      lapack=openblas
```

BLAS/LAPACK Runtime Switch: Developer Guide
===========================================

## BLAS/LAPACK package Maintainers

0. Provide extra shared objects in a private library directory, e.g.
`/usr/lib64/blas/<foobar>/lib{,c}blas.so{,.3}`,
`/usr/lib64/lapack/<foobar>/liblapack.so{,.3}`. These private libraries must
have matching file names and SONAMEs. (Not mandatory for special cases such as
MKL)

1. Register an alternative with `eselect blas add ...` during postinst.

2. Remove an alternative with `eselect blas validate` during postrm.

Examples: ebuild files for `sci-libs/lapack`, `sci-libs/blis`, `sci-libs/openblas`.

## BLAS/LAPACK Reverse Dependency Maintainers

If your package needs to be linked against the reference (aka. netlib) BLAS
and LAPACK, please add corresponding virtual packages in the dependency, i.e.
`virtual/{blas,cblas,lapack,lapacke}`. Any package to be linked against
these virtual packages must assume a standard (reference) API and ABI.
Otherwise, please write a specific implementation in the dependency list,
e.g. `sci-libs/blis`, and link the ELF files against e.g. `-lblis`.
