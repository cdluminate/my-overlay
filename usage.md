GSoC2019/Gentoo: BLAS/LAPACK Runtime Switch
===========================================

Table of Contents

1. BLAS/LAPACK Runtime Switch: User Guide
2. BLAS/LAPACK Runtime Switch: Developer Guide
3. Implementation Details
5. Frequently Asked Questions

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

Directly run your program again and see if it's running faster. No any
re-compilation is required thanks to this mechanism. For more details
about the `eselect blas` or `eselect-lapack` usage please look up the
manual page or the help messages.

## 64-Bit Indexing Variants of BLAS and LAPACK

Work in progress.

## Side Notes

List of BLAS/LAPACK providers (`eselect-ldso`):

* `sci-libs/lapack`: the reference blas/cblas/lapack/lapacke, only supports
  serial mode.
* `sci-libs/blis`: optimized blas/cblas implementation.
* `sci-libs/openblas`: optimized blas/cblas + partially optimized
  lapack/lapacke.
* `sci-libs/mkl-rt`: Intel's math kernel library. optimized
  blas/cblas/lapack/lapcke/etc implementation.

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

In case of package confliction (Block) during transition:

```
* Keep >=virtual/{blas,cblas,lapack}-3.8
* Keep >=sci-libs/lapack-3.8 as it replaces all the
  sci-lib/{blas,cblas,lapack,lapacke}-reference packages.
  The *-reference packages should be unmerged.
* Keep >=app-eselect/eslect-{blas,lapack}-0.2 .
  app-eselect/eselect-cblas-* has been deprecated.
```

## Pitfalls

1. Please don't use pthread and openmp at the same time since it may incur
significant performance drop due to excessive thread creation. This may happen
when some libraries linked against an application use OpenMP threading, whiles
some other use pthread.

2. Please don't use GNU OpenMP (`libgomp.so`) and (`libiomp.so`) at the same
time as the symbol clash between them may lead to silent computation error.
This may happen when MKL uses Intel/LLVM OpenMP while some other libraries
linked against the same application use GNU OpenMP.

BLAS/LAPACK Runtime Switch: Developer Guide
===========================================

## BLAS/LAPACK Providers

It must be pointed out that for any BLAS/LAPACK implementation, providing extra
shared object with proper SONAMEs is necessary. For example, we cannot use
`libopenblas.so.0 (SONAME=libopenblas.so.0)` as the BLAS/CBLAS provider by
simply symlinking it into `libblas.so{,.3}` and `libcblas.so{,.3}` because any
program to be linked against BLAS (`-lblas`) or CBLAS (`-lcblas`) will be
eventually linked against `libopenblas.so.0` (you can verify this with `readelf
-d foobar`), which will clearly break the runtime switching mechanism. The
current solution is to patch upstream build systems and build customized shared
objects with proper SONAMEs.

To package a BLAS/LAPACK provider with the runtime switching feature enabled,
the maintainer should pay attention to the following points:

1. Patch upstream build systems and provide extra shared objects in a private
   library directory. Specifially, a new BLAS/CBLAS implementation, say
"myblas", should install 4 files to the `/usr/lib64/blas/<myblas>/` directory:
(1) `libblas.so.3` (ELF shared object, providing the fortran BLAS ABI,
SONAME=`libblas.so.3`); (2) `libblas.so` (symlink pointing to `libblas.so.3`);
(3) `libcblas.so.3` (ELF shared object, providing the C BLAS ABI,
SONAME=`libcblas.so.3`); (4) `libcblas.so` (symlink pointing to
`libcblas.so.3`). Similarly, a new LAPACK implementation, say "mylapack" should
install 2 files to the `/usr/lib64/blas/<mylapack>` directory: (1)
`liblapack.so.3` (ELF shared object, providing the fortran LAPACK ABI,
SONAME=`liblapack.so.3`); (2) `liblapack.so` (symlink pointing to
`liblapack.so`).

2. Register an alternative with `eselect blas add ...` during postinst.

3. Remove an alternative with `eselect blas validate` during postrm.

4. Guard the code associated with all the above points with the `eselect-ldso`
   USE flag.

For real example please see ebuild files for `>=sci-libs/lapack-3.8.0`,
`>=sci-libs/blis-0.5.2`, `>=sci-libs/openblas-0.3.5`.

## BLAS/LAPACK Reverse Dependencies

If a package needs to be linked against the reference (aka. netlib) BLAS and
LAPACK, it should declare virtual packages dependency, i.e.
`virtual/{blas,cblas,lapack,lapacke}` instead of a specific implementation.  In
this case the package must assume a standard (reference) API and ABI from the
virtual package. Otherwise, please write a specific implementation in the
dependency list and avoid linking against `-l{,c}blas` or `-llapack`.

Implementation Details
======================

The core part of the implementation involves `>=sci-libs/lapack-3.8.0`,
`>=eselect-blas-0.2` and `>=eselect-lapack-0.2`, where the former one controls
both (fortran) BLAS and CBLAS alternatives at the same time.

The `sci-libs/lapack` is codebase of the reference (or standard) BLAS, CBLAS,
LAPACK, and LAPACKE. BLAS and LAPACK are a set of stable Fortran API / ABI.
CBLAS and LAPACKE are thin wrappers around BLAS and LAPACK respectively,
providing the C API / ABI. In our BLAS/LAPACK runtime switching mechanism,
every candidate must provide every API / ABI that the reference implementation
provides. Taking advantage of the API/ABI stability, we can change the backend
libraries (e.g. `libblas.so.3`) without recompiling applications as long as the
new one provides a compatible set of ABI.

The users could easily switch the libraries by adjusting the `LD_LIBRARY_PATH`
environment variables as a temporary solution. For system level library
switching, two custom eselect modules (`eselect-blas`, `eselect-lapack`) are
provided. They manipulates configuration files under the `/etc/ld.so.conf.d/`
directory, hinting `ld.so` on the places to find the BLAS/LAPACK libraries.

As a side effect, this solution depends on the `ld.so.conf` support from the
system C standard library. Besides, It's recommended to read the code if
you need even more details.

Frequently Asked Questions
==========================

**Q:** I disabled this feature when installing a bunch of packages, but now I
regret and want to enable the runtime switching feature. How should I do?

A: Simply reinstall the virtual packages and your favorate BLAS/LAPACK
providers with the `eselect-ldso` flag toggled. The whole dependency tree
doesn't need to be rebuilt as a rebuild is expected to make no difference.

**Q:** Some BLAS/LAPACK implementations support 64-bit array indexing, which provides
functions such as `sasum(int64_t N, float* X, int64_t INCX)`. How does this
mechanism deal with such feature?

A: The "BLAS64" or "BLAS-ILP64" ABI is different from the "BLAS32" or
"BLAS-LP64" ABI. Mixing them together will lead to unpredictable results, hence
the "BLAS64" feature is not integrated into the mechanism. When the demand on
"BLAS64" is common enough, we could provide another pair of eselect modules,
i.e. `eselect-blas64` and `eselect-lapack64`.

**Q:** How do I add a customized implementation into this mechanism?

A: Taking MKL as an example. We first install MKL to `/path/to/mkl`, and
symlink `/path/to/mkl/libmkl_rt.so` to `/path/to/mkl/lib{,c}blas.so{,.3}`.
Then register it with `eselect blas add lib64 /path/to/mkl/ mkl`. Note that
building programs when MKL is selected is discouraged. The reason could be
found in the developer guide part.

A real example about adding and setting Intel MKL as the backend library:
```
# pip install mkl --user
# cd ~/.local/lib/
# ln -s libmkl_rt.so libblas.so.3
# ln -s libmkl_rt.so libblas.so  
# ln -s libmkl_rt.so libcblas.so.3
# ln -s libmkl_rt.so libcblas.so  
# eselect blas add lib64 $(pwd) mkl
# ln -s libmkl_rt.so liblapack.so.3
# ln -s libmkl_rt.so liblapack.so  
# eselect lapack add lib64 $(pwd) mkl
# eselect blas set mkl
# eselect lapack set mkl
```

To remove the MKL candidate or any other customized library, just remove the
corresponding files under `/etc/env.d/blas/` and `/etc/env.d/lapack/`
directories, then select some other candidates. Note, the
`sci-libs/mkl-rt::gentoo` can do all the above steps for you.

Authors, Acknowledgement, Credits
==================================

Author: Mo Zhou <lumin@debian.org>
GSoC Mentor: Benda Xu <heroxbd@gentoo.org>

This work is supported by Google through Google Summer of Code. [Project Link](https://summerofcode.withgoogle.com/projects/#6268942782300160)

Thanks to Zongyu Zhang who [fixed a bug in numpy ebuild](https://github.com/gentoo/gentoo/commit/f5c71a4aa9615c8c14caa8e7076519ab2a4b9824#diff-e86a27d02ab70b6118a6b04d18ff075e)
so that numpy could make use of the switching mechanism correctly.

User Feedbacks
==============

Positive ones:

https://github.com/gentoo/sci/issues/805#issuecomment-510469206
https://github.com/gentoo/sci/issues/805#issuecomment-512097570

Negative ones: None yet.
