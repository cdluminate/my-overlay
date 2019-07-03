GSoC2019/Gentoo: BLAS/LAPACK Runtime Switch
===========================================

Table of Contents

1. BLAS/LAPACK Runtime Switch: User Guide
2. BLAS/LAPACK Runtime Switch: Developer Guide
3. Implementation Details
4. Frequently Asked Questions

BLAS/LAPACK Runtime Switch: User Guide
======================================

## Disabling The Feature

This feature is disabled by default, which means users who don't care about it
could simply ignore the `eselect-ldso` USE flag as if it doesn't exist and
install things under the default settings like before. Users who don't read any
documentation at all won't fall into trouble with this default setting.

## Enabling The Feature 

First install the skeleton of the mechanism:

```
# USE=eselect-ldso emerge --ask >=virtual/blas-3.8 >=virtual/lapack-3.8
```

These virtual packages will pull in the reference BLAS/LAPACK implementation
and the customized eselect modules for BLAS and LAPACK, i.e.
(`>=sci-libs/lapack-3.8.0`, `>=app-eselect/eselect-blas-0.2`,
`>=app-eselect/eselect-lapack-0.2`). After finishing the installation, the user
should be able to check the status of BLAS/LAPACK selections: 

```
# eselect blas list
Available BLAS/CBLAS (lib64) candidates:
  [1]   reference *
# eselect lapack list
Available LAPACK (lib64) candidates:
  [1]   reference *
```

That means all binaries linked against `libblas.so.3` or `libcblas.so.3` will
use the `reference` BLAS implementation; those linked against `liblapack.so.3`
will use the `reference` LAPACK implementation.

The reference implementation is very slow, and for some users (e.g. scientific
computing users) this is unacceptable. In Gentoo's main repo there are several
typical optimized BLAS/LAPACK implementations available, for example BLIS and
OpenBLAS. They could be automatically registered in the mechanism as long as
the `eselect-ldso` USE flag is toggled during installation. For example:

```
# USE=eselect-ldso emerge --ask >=sci-libs/blis-0.6.0
# USE=eselect-ldso emerge --ask >=sci-libs/openblas-0.3.5
```

Note that without the `eselect-ldso` flag, these packages won't be registered
in the mechanism and won't install extra libraries at all. After installation
with the feature enabled, we could switch the BLAS/LAPACK implementation like
so:

```
# eselect blas set openblas
# eselect lapack set openblas
```

Run your program again and see if it's running more faster than before. No
any recompilation is required with this mechanism.

## Side Notes

Here are some recommended combinations for your choice:

```
* blas=openblas  lapack=openblas   (priority: high)
* blas=blis      lapack=reference  (priority: medium)
* blas=reference lapack=reference  (priority: low)
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

Implementation Details
======================

eselect + ld.so.conf

Frequently Asked Questions
==========================

1. MKL?
