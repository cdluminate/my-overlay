Reverse Dependency Checklist
============================

(RR = reference+reference, BR=blis+reference, OO=openblas+openblas, x=FINE, ?=Installed but dont know how to test, -=pending, /=skip)

[ ] armadillo
[ ] cholmod?
[ ] gimp
[ ] liblbfgs
[ ] liblinear
[ ] libreoffice
[ ] libsvm
[ ] ltfatpy
[ ] python-cvxopt
[ ] r-core
[ ] sagemath
[ ] scalapack
[ ] scilab
[-] scipy-1.1.0 [RR,OO=OK, BR=10 FAIL]
[ ] suitesparse?
[ ] sundials
[ ] superlu
[ ] umfpack
[?] arpack-3.1.5
[?] p4est-2.2
[x] numpy-1.16.1-r1 [RR,BR,OO=OK]
[x] octave-4.2.2 [RR,BR,OO=fine]
[/] gretl-1.9.90 [FAIL, unrelated]

virtual/blas
============

dev-libs/igraph/igraph-0.7.1-r2.ebuild
20:	virtual/blas

sci-libs/punc/punc-1.5.ebuild
27:	virtual/blas

sci-libs/cgcode/cgcode-1.0-r2.ebuild
17:RDEPEND="virtual/blas"

sci-libs/coinor-utils/coinor-utils-2.9.11.ebuild
22:	blas? ( virtual/blas )

dev-libs/liblinear/liblinear-210-r1.ebuild
18:	blas? ( virtual/blas )

dev-libs/liblinear/liblinear-230.ebuild
17:	blas? ( virtual/blas )

dev-libs/liblinear/liblinear-221.ebuild
17:	blas? ( virtual/blas )

sci-libs/shogun/shogun-5.0.0.ebuild
49:	virtual/blas

sci-libs/superlu/superlu-5.2.1-r1.ebuild
32:RDEPEND="virtual/blas"

sci-libs/superlu/superlu-4.3-r1.ebuild
23:	virtual/blas"

sci-libs/hypre/hypre-2.9.0b.ebuild
21:	virtual/blas

sci-libs/hypre/hypre-2.14.0.ebuild
21:	virtual/blas

sci-libs/hypre/hypre-2.11.1.ebuild
21:	virtual/blas

sci-libs/hypre/hypre-2.11.2.ebuild
21:	virtual/blas

sci-libs/mumps/mumps-5.1.2.ebuild
20:	virtual/blas

sci-libs/libghemical/libghemical-3.0.0.ebuild
21:		virtual/blas

sci-libs/lapack-reference/lapack-reference-3.2.1-r4.ebuild
24:	virtual/blas"

sci-libs/lapack-reference/lapack-reference-3.6.0.ebuild
18:	>=virtual/blas-3.6

sci-libs/lapack-reference/lapack-reference-3.7.0.ebuild
18:	>=virtual/blas-3.6

dev-libs/starpu/starpu-1.2.6.ebuild
25:	blas? ( virtual/blas )

sci-libs/cblas-reference/cblas-reference-20151113-r2.ebuild
22:	>=virtual/blas-3.6

sci-libs/cblas-reference/cblas-reference-20161223.ebuild
22:	>=virtual/blas-3.6

sci-libs/cblas-reference/cblas-reference-20030223-r6.ebuild
20:	virtual/blas

sci-libs/ipopt/ipopt-3.11.8.ebuild
24:	virtual/blas

sci-libs/ipopt/ipopt-3.12.12.ebuild
24:	virtual/blas

sci-libs/ipopt/ipopt-3.11.7.ebuild
23:	virtual/blas

sci-libs/clblas/clblas-2.10.ebuild
35:	   virtual/blas

sci-libs/armadillo/armadillo-9.200.6.ebuild
25:	blas? ( virtual/blas )

sci-libs/armadillo/armadillo-9.200.5.ebuild
25:	blas? ( virtual/blas )

sci-libs/armadillo/armadillo-8.300.2.ebuild
25:	blas? ( virtual/blas )

sci-libs/mc/mc-1.5.ebuild
27:	virtual/blas

sci-libs/libsc/libsc-2.0.ebuild
31:	virtual/blas

sci-libs/libsc/libsc-2.2.ebuild
31:	virtual/blas

sci-libs/libsc/libsc-9999.ebuild
31:	virtual/blas

sci-libs/libsc/libsc-1.1-r1.ebuild
22:	virtual/blas

sci-libs/libsc/libsc-1.0-r1.ebuild
22:	virtual/blas

sci-libs/umfpack/umfpack-5.6.2.ebuild
20:	virtual/blas

sci-libs/superlu_mt/superlu_mt-3.1.ebuild
21:RDEPEND="virtual/blas"

sci-libs/clapack/clapack-3.2.1-r8.ebuild
19:	virtual/blas"

sci-libs/levmar/levmar-2.6.ebuild
18:	virtual/blas

sci-libs/taucs/taucs-2.2.ebuild
18:	virtual/blas

sci-libs/pastix/pastix-5.2.3.ebuild
30:	virtual/blas

sci-libs/pastix/pastix-5.2.2.22-r1.ebuild
37:	virtual/blas

sci-libs/coinor-csdp/coinor-csdp-6.1.1-r1.ebuild
20:	virtual/blas

sci-libs/scikits_learn/scikits_learn-0.17.ebuild
29:	virtual/blas
38:	virtual/blas

sci-libs/scikits_learn/scikits_learn-0.18.1.ebuild
29:	virtual/blas
38:	virtual/blas

sci-libs/scikits_learn/scikits_learn-0.17.1.ebuild
29:	virtual/blas
38:	virtual/blas

sci-libs/scikits_learn/scikits_learn-0.18.2.ebuild
29:	virtual/blas
38:	virtual/blas

sci-libs/scikits_learn/scikits_learn-0.18.2-r1.ebuild
31:	virtual/blas:=
40:	virtual/blas:=

sci-libs/scikits_learn/scikits_learn-0.19.0.ebuild
31:	virtual/blas:=
40:	virtual/blas:=

sci-libs/itpp/itpp-4.3.1-r1.ebuild
19:	virtual/blas

sci-libs/coinhsl/coinhsl-2015.06.23.ebuild
20:	virtual/blas"

sci-libs/coinhsl/coinhsl-2014.01.10.ebuild
22:	virtual/blas"

dev-python/cvxopt/cvxopt-1.1.9.ebuild
20:	virtual/blas

sci-physics/lammps/lammps-20160301.ebuild
30:		virtual/blas

sci-physics/lammps/lammps-20151120.ebuild
28:		virtual/blas

sci-physics/lammps/lammps-20180222.ebuild
37:	virtual/blas

sci-physics/lammps/lammps-20180308.ebuild
37:	virtual/blas

sci-physics/lammps/lammps-20170901.ebuild
37:	virtual/blas

sci-physics/lammps/lammps-20151209.ebuild
28:		virtual/blas

sci-physics/lammps/lammps-20160407.ebuild
34:	virtual/blas

sci-physics/lammps/lammps-20190605.ebuild
39:	virtual/blas

sci-physics/lammps/lammps-20181212.ebuild
39:	virtual/blas

sci-physics/lammps/lammps-20160730.ebuild
34:	virtual/blas

sci-physics/lammps/lammps-20150210.ebuild
52:		virtual/blas

sci-physics/lammps/lammps-20180316.ebuild
37:	virtual/blas

sci-physics/lammps/lammps-20151208.ebuild
28:		virtual/blas

sci-physics/lammps/lammps-20160310.ebuild
30:		virtual/blas

sci-physics/lammps/lammps-20160216.ebuild
30:		virtual/blas

sci-physics/lammps/lammps-20151106.ebuild
28:		virtual/blas

sci-physics/lammps/lammps-20170706.ebuild
34:	virtual/blas

sci-physics/lammps/lammps-20160115.ebuild
30:		virtual/blas

sci-physics/lammps/lammps-20180822.ebuild
37:	virtual/blas

sci-physics/lammps/lammps-20151207.ebuild
28:		virtual/blas

sci-physics/lammps/lammps-20160122.ebuild
30:		virtual/blas

sci-physics/lammps/lammps-20150515-r1.ebuild
54:		virtual/blas

sci-physics/lammps/lammps-20151211.ebuild
28:		virtual/blas

sci-physics/lammps/lammps-20150515.ebuild
54:		virtual/blas

sci-physics/lammps/lammps-20160314.ebuild
30:		virtual/blas

sci-physics/lammps/lammps-20150810.ebuild
54:		virtual/blas

sci-physics/lammps/lammps-20160321.ebuild
30:		virtual/blas

sci-physics/lammps/lammps-20180117.ebuild
37:	virtual/blas

sci-physics/lammps/lammps-20170109.ebuild
34:	virtual/blas

sci-physics/lammps/lammps-20170901-r1.ebuild
37:	virtual/blas

sci-physics/sassena/sassena-1.4.2.ebuild
22:	virtual/blas

sci-chemistry/psi/psi-3.4.0-r2.ebuild
19:	virtual/blas

sci-chemistry/freeon/freeon-1.0.8-r1.ebuild
23:	virtual/blas

sci-chemistry/freeon/freeon-1.0.10.ebuild
22:	virtual/blas

sci-chemistry/gromacs/gromacs-2019.3.ebuild
43:	blas? ( virtual/blas )

sci-chemistry/gromacs/gromacs-2018.7.ebuild
41:	blas? ( virtual/blas )

sci-chemistry/gromacs/gromacs-2018.3.ebuild
41:	blas? ( virtual/blas )

sci-chemistry/gromacs/gromacs-2018.9999.ebuild
41:	blas? ( virtual/blas )

sci-chemistry/gromacs/gromacs-2019.9999.ebuild
43:	blas? ( virtual/blas )

sci-chemistry/gromacs/gromacs-2019.2.ebuild
43:	blas? ( virtual/blas )

sci-chemistry/gromacs/gromacs-9999.ebuild
41:	blas? ( virtual/blas )

sci-chemistry/mpqc/mpqc-2.3.1-r4.ebuild
18:	virtual/blas

sci-chemistry/apbs/apbs-1.4.1-r2.ebuild
30:	virtual/blas

sci-astronomy/casacore/casacore-2.3.0-r1.ebuild
24:	virtual/blas:=

dev-lang/R/R-3.5.3.ebuild
30:	virtual/blas:0

dev-lang/R/R-3.6.0.ebuild
30:	virtual/blas:0

dev-lang/R/R-3.4.1.ebuild
29:	virtual/blas:0

dev-lang/julia/julia-1.1.0.ebuild
54:	>=virtual/blas-3.6

dev-lang/julia/julia-9999.ebuild
45:	>=virtual/blas-3.6

dev-lang/julia/julia-1.1.1.ebuild
54:	>=virtual/blas-3.6

sys-cluster/hpl/hpl-2.0-r3.ebuild
18:	virtual/blas

sci-geosciences/grass/grass-7.4.4.ebuild
38:		virtual/blas

sci-mathematics/octave/octave-4.4.1.ebuild
24:	virtual/blas

sci-mathematics/octave/octave-4.4.0.ebuild
24:	virtual/blas

sci-mathematics/octave/octave-4.2.2.ebuild
24:	virtual/blas

media-gfx/hugin/hugin-2019.0.0.ebuild
43:	lapack? ( virtual/blas virtual/lapack )

media-gfx/hugin/hugin-9999.ebuild
45:	lapack? ( virtual/blas virtual/lapack )

sci-mathematics/gsl-shell/gsl-shell-2.3.0_beta1.ebuild
20:	virtual/blas

sci-mathematics/Macaulay2/Macaulay2-1.8.2.1-r1.ebuild
44:	virtual/blas

sci-mathematics/jags/jags-3.4.0.ebuild
20:	virtual/blas

sci-mathematics/jags/jags-4.2.0.ebuild
20:	virtual/blas

sci-mathematics/jags/jags-4.1.0.ebuild
20:	virtual/blas

sci-mathematics/jags/jags-4.0.0.ebuild
20:	virtual/blas

profiles/arch/mips/use.mask
105:# virtual/blas virtual/cblas and virtual/lapack not keyworded

virtual/cblas
=============

sci-libs/clblast/clblast-0.10.0.ebuild
22:	  virtual/cblas

sci-libs/scipy/scipy-1.1.0.ebuild
30:	virtual/cblas

sci-libs/scipy/scipy-1.0.0.ebuild
30:	virtual/cblas

sci-libs/scipy/scipy-0.18.1.ebuild
30:	virtual/cblas

sci-libs/scipy/scipy-9999.ebuild
25:	virtual/cblas

sci-libs/scipy/scipy-0.19.1.ebuild
30:	virtual/cblas

sci-libs/scipy/scipy-0.16.1.ebuild
30:	virtual/cblas

sci-libs/shogun/shogun-5.0.0.ebuild
50:	virtual/cblas

sci-libs/dlib/dlib-19.4.ebuild
21:	cblas? ( virtual/cblas:= )

sci-libs/dlib/dlib-19.16.ebuild
23:	cblas? ( virtual/cblas:= )

sci-libs/dlib/dlib-19.9.ebuild
20:	cblas? ( virtual/cblas:= )

sci-libs/dlib/dlib-19.7.ebuild
20:	cblas? ( virtual/cblas:= )

sci-libs/dlib/metadata.xml
15:    <flag name="cblas">Build with CBLAS <pkg>virtual/cblas</pkg></flag>

sci-libs/magma/magma-1.4.0.ebuild
25:	virtual/cblas

sci-libs/magma/magma-1.4.1.ebuild
25:	virtual/cblas

sci-libs/o2scl/o2scl-0.920.ebuild
20:	virtual/cblas:=

sci-libs/gsl/gsl-2.5-r1.ebuild
18:RDEPEND="cblas-external? ( virtual/cblas:= )"

sci-libs/gsl/gsl-2.4.ebuild
18:RDEPEND="cblas-external? ( virtual/cblas:= )"

sci-libs/gsl/gsl-1.16.ebuild
18:RDEPEND="cblas-external? ( virtual/cblas )"

sci-libs/gsl/gsl-2.5.ebuild
18:RDEPEND="cblas-external? ( virtual/cblas:= )"

sci-libs/gsl/metadata.xml
23:    (<pkg>virtual/cblas</pkg>) instead of shipped internal version</flag>

sci-libs/scikits_learn/scikits_learn-0.17.ebuild
30:	virtual/cblas
39:	virtual/cblas

sci-libs/scikits_learn/scikits_learn-0.17.1.ebuild
30:	virtual/cblas
39:	virtual/cblas

sci-libs/scikits_learn/scikits_learn-0.18.2.ebuild
30:	virtual/cblas
39:	virtual/cblas

sci-libs/scikits_learn/scikits_learn-0.18.2-r1.ebuild
32:	virtual/cblas:=
41:	virtual/cblas:=

sci-libs/scikits_learn/scikits_learn-0.19.0.ebuild
32:	virtual/cblas:=
41:	virtual/cblas:=

sci-libs/scikits_learn/scikits_learn-0.18.1.ebuild
30:	virtual/cblas
39:	virtual/cblas

dev-python/numpy/numpy-1.15.4.ebuild
30:RDEPEND="lapack? ( virtual/cblas virtual/lapack )"

dev-python/numpy/numpy-1.16.1.ebuild
31:		virtual/cblas

dev-python/numpy/numpy-1.14.5.ebuild
30:RDEPEND="lapack? ( virtual/cblas virtual/lapack )"

dev-python/numpy/numpy-1.8.2.ebuild
31:	lapack? ( virtual/cblas virtual/lapack )"

sci-biology/plink/plink-1.90_pre140514.ebuild
22:	virtual/cblas

sci-mathematics/xmds/xmds-2.2.2.ebuild
28:#virtual/cblas

profiles/arch/mips/use.mask
79:# cblas-external as virtual/cblas is also masked
105:# virtual/blas virtual/cblas and virtual/lapack not keyworded

profiles/arch/arm/use.mask
40:# cblas-external as virtual/cblas is also masked

profiles/arch/arm64/package.use.mask
470:# virtual/cblas not keyworded on arm, bug #455050.

profiles/arch/arm64/use.mask
72:# cblas-external as virtual/cblas is also masked

profiles/arch/sh/use.mask
9:# cblas-external as virtual/cblas is also masked

virtual/lapack
==============

profiles/use.desc
162:lapack - Add support for the virtual/lapack numerical library

dev-libs/igraph/igraph-0.7.1-r2.ebuild
21:	virtual/lapack

sci-libs/punc/punc-1.5.ebuild
28:	virtual/lapack

sci-libs/arpack/arpack-3.5.0.ebuild
23:	virtual/lapack

sci-libs/arpack/arpack-3.1.5.ebuild
27:	virtual/lapack

sci-libs/arpack/arpack-3.4.0.ebuild
23:	virtual/lapack

sci-libs/arpack/arpack-9999.ebuild
26:	virtual/lapack

sci-libs/p4est/p4est-2.0.ebuild
39:	virtual/lapack

sci-libs/p4est/p4est-9999.ebuild
39:	virtual/lapack

sci-libs/p4est/p4est-1.1.ebuild
30:	virtual/lapack

sci-libs/p4est/p4est-2.2.ebuild
39:	virtual/lapack

sci-libs/p4est/p4est-1.0.ebuild
30:	virtual/lapack

sci-libs/scipy/scipy-1.0.0.ebuild
31:	virtual/lapack

sci-libs/scipy/scipy-0.19.1.ebuild
31:	virtual/lapack

sci-libs/scipy/scipy-0.16.1.ebuild
31:	virtual/lapack

sci-libs/scipy/scipy-9999.ebuild
26:	virtual/lapack

sci-libs/scipy/scipy-1.1.0.ebuild
31:	virtual/lapack

sci-libs/scipy/scipy-0.18.1.ebuild
31:	virtual/lapack

sci-libs/coinor-utils/coinor-utils-2.9.11.ebuild
24:	lapack? ( virtual/lapack )

sci-libs/spqr/spqr-1.3.1.ebuild
17:	virtual/lapack

sci-libs/shogun/shogun-5.0.0.ebuild
51:	virtual/lapack

sci-libs/dsdp/dsdp-5.8-r3.ebuild
19:RDEPEND="virtual/lapack"

sci-libs/dlib/dlib-19.9.ebuild
23:	lapack? ( virtual/lapack:= )

sci-libs/dlib/dlib-19.4.ebuild
24:	lapack? ( virtual/lapack:= )

sci-libs/dlib/dlib-19.16.ebuild
27:	lapack? ( virtual/lapack:= )

sci-libs/dlib/dlib-19.7.ebuild
23:	lapack? ( virtual/lapack:= )

sci-libs/hypre/hypre-2.11.1.ebuild
22:	virtual/lapack

sci-libs/hypre/hypre-2.14.0.ebuild
22:	virtual/lapack

sci-libs/hypre/hypre-2.9.0b.ebuild
22:	virtual/lapack

sci-libs/hypre/hypre-2.11.2.ebuild
22:	virtual/lapack

sci-libs/libghemical/libghemical-3.0.0.ebuild
22:		virtual/lapack

sci-libs/magma/magma-1.4.0.ebuild
26:	virtual/lapack"

sci-libs/magma/magma-1.4.1.ebuild
26:	virtual/lapack"

sci-libs/ceres-solver/ceres-solver-1.11.0.ebuild
24:	lapack? ( virtual/lapack )

sci-libs/ceres-solver/ceres-solver-1.12.0.ebuild
24:	lapack? ( virtual/lapack )

sci-libs/sundials/sundials-3.1.2.ebuild
22:	lapack? ( virtual/lapack )

sci-libs/sundials/sundials-3.1.0.ebuild
22:	lapack? ( virtual/lapack )

sci-libs/sundials/sundials-3.0.0.ebuild
22:	lapack? ( virtual/lapack )

sci-libs/sundials/sundials-2.7.0.ebuild
22:	lapack? ( virtual/lapack )

sci-libs/scalapack/scalapack-2.0.2-r1.ebuild
18:	virtual/lapack

sci-libs/ipopt/ipopt-3.12.12.ebuild
26:	lapack? ( virtual/lapack )

sci-libs/ipopt/ipopt-3.11.8.ebuild
26:	lapack? ( virtual/lapack )

sci-libs/ipopt/ipopt-3.11.7.ebuild
25:	lapack? ( virtual/lapack )

sci-libs/armadillo/armadillo-9.200.6.ebuild
26:	lapack? ( virtual/lapack )

sci-libs/armadillo/armadillo-9.200.5.ebuild
26:	lapack? ( virtual/lapack )

sci-libs/armadillo/armadillo-8.300.2.ebuild
26:	lapack? ( virtual/lapack )

sci-libs/mc/mc-1.5.ebuild
28:	virtual/lapack"

sci-libs/libsc/libsc-2.2.ebuild
32:	virtual/lapack

sci-libs/libsc/libsc-2.0.ebuild
32:	virtual/lapack

sci-libs/libsc/libsc-9999.ebuild
32:	virtual/lapack

sci-libs/libsc/libsc-1.1-r1.ebuild
23:	virtual/lapack

sci-libs/libsc/libsc-1.0-r1.ebuild
23:	virtual/lapack

sci-libs/qrupdate/qrupdate-1.1.2-r1.ebuild
17:RDEPEND="virtual/lapack"

sci-libs/levmar/levmar-2.6.ebuild
19:	virtual/lapack"

sci-libs/ViSP/ViSP-3.0.1-r1.ebuild
28:	lapack? ( virtual/lapack )

sci-libs/ViSP/ViSP-3.1.0-r1.ebuild
27:	lapack? ( virtual/lapack )

sci-libs/taucs/taucs-2.2.ebuild
19:	virtual/lapack

sci-libs/coinor-csdp/coinor-csdp-6.1.1-r1.ebuild
21:	virtual/lapack"

sci-libs/itpp/itpp-4.3.1-r1.ebuild
20:	virtual/lapack

sci-libs/cholmod/cholmod-2.1.2.ebuild
21:	lapack? ( virtual/lapack )

sci-libs/gerris/gerris-20131206-r1.ebuild
33:	virtual/lapack

sci-physics/lammps/lammps-20180308.ebuild
38:	virtual/lapack

sci-physics/lammps/lammps-20160407.ebuild
35:	virtual/lapack

sci-physics/lammps/lammps-20151120.ebuild
29:		virtual/lapack

sci-physics/lammps/lammps-20170901.ebuild
38:	virtual/lapack

sci-physics/lammps/lammps-20151209.ebuild
29:		virtual/lapack

sci-physics/lammps/lammps-20180222.ebuild
38:	virtual/lapack

sci-physics/lammps/lammps-20181212.ebuild
40:	virtual/lapack

sci-physics/lammps/lammps-20160301.ebuild
31:		virtual/lapack

sci-physics/lammps/lammps-20190605.ebuild
40:	virtual/lapack

sci-physics/lammps/lammps-20150210.ebuild
53:		virtual/lapack

sci-physics/lammps/lammps-20160730.ebuild
35:	virtual/lapack

sci-physics/lammps/lammps-20160310.ebuild
31:		virtual/lapack

sci-physics/lammps/lammps-20151208.ebuild
29:		virtual/lapack

sci-physics/lammps/lammps-20151106.ebuild
29:		virtual/lapack

sci-physics/lammps/lammps-20170706.ebuild
35:	virtual/lapack

sci-physics/lammps/lammps-20160115.ebuild
31:		virtual/lapack

sci-physics/lammps/lammps-20180316.ebuild
38:	virtual/lapack

sci-physics/lammps/lammps-20180822.ebuild
38:	virtual/lapack

sci-physics/lammps/lammps-20151207.ebuild
29:		virtual/lapack

sci-physics/lammps/lammps-20160122.ebuild
31:		virtual/lapack

sci-physics/lammps/lammps-20150515-r1.ebuild
55:		virtual/lapack

sci-physics/lammps/lammps-20151211.ebuild
29:		virtual/lapack

sci-physics/lammps/lammps-20150515.ebuild
55:		virtual/lapack

sci-physics/lammps/lammps-20180117.ebuild
38:	virtual/lapack

sci-physics/lammps/lammps-20150810.ebuild
55:		virtual/lapack

sci-physics/lammps/lammps-20160314.ebuild
31:		virtual/lapack

sci-physics/lammps/lammps-20170901-r1.ebuild
38:	virtual/lapack

sci-physics/lammps/lammps-20160321.ebuild
31:		virtual/lapack

sci-physics/lammps/lammps-20160216.ebuild
31:		virtual/lapack

sci-physics/lammps/lammps-20170109.ebuild
35:	virtual/lapack

sci-physics/cernlib/cernlib-2006-r6.ebuild
25:	virtual/lapack

sci-physics/cernlib/cernlib-2006-r7.ebuild
25:	virtual/lapack

sci-physics/cernlib/cernlib-2006-r5.ebuild
26:	virtual/lapack

sci-physics/sassena/sassena-1.4.2.ebuild
23:	virtual/lapack

dev-python/cvxopt/cvxopt-1.1.9.ebuild
21:	virtual/lapack

sci-physics/harminv/harminv-1.3.1-r1.ebuild
17:RDEPEND="virtual/lapack"

dev-python/numpy/numpy-1.15.4.ebuild
30:RDEPEND="lapack? ( virtual/cblas virtual/lapack )"

dev-python/numpy/numpy-1.8.2.ebuild
31:	lapack? ( virtual/cblas virtual/lapack )"

dev-python/numpy/numpy-1.16.1.ebuild
32:		virtual/lapack

dev-python/numpy/numpy-1.14.5.ebuild
30:RDEPEND="lapack? ( virtual/cblas virtual/lapack )"

sci-chemistry/psi/psi-3.4.0-r2.ebuild
20:	virtual/lapack

sci-chemistry/freeon/freeon-1.0.10.ebuild
23:	virtual/lapack"

sci-chemistry/freeon/freeon-1.0.8-r1.ebuild
24:	virtual/lapack"

sci-chemistry/gromacs/gromacs-2019.3.ebuild
48:	lapack? ( virtual/lapack )

sci-chemistry/gromacs/gromacs-2019.9999.ebuild
48:	lapack? ( virtual/lapack )

sci-chemistry/gromacs/gromacs-2018.3.ebuild
46:	lapack? ( virtual/lapack )

sci-chemistry/gromacs/gromacs-2018.7.ebuild
46:	lapack? ( virtual/lapack )

sci-chemistry/gromacs/gromacs-2018.9999.ebuild
46:	lapack? ( virtual/lapack )

sci-chemistry/gromacs/gromacs-2019.2.ebuild
48:	lapack? ( virtual/lapack )

sci-chemistry/gromacs/gromacs-9999.ebuild
46:	lapack? ( virtual/lapack )

media-libs/opencv/opencv-3.4.1-r5.ebuild
81:	lapack? ( virtual/lapack )

sci-chemistry/mpqc/mpqc-2.3.1-r4.ebuild
19:	virtual/lapack

sci-astronomy/casacore/casacore-2.3.0-r1.ebuild
25:	virtual/lapack:=

sci-biology/vcftools/vcftools-0.1.14.ebuild
19:	lapack? ( virtual/lapack )"

sci-biology/plink/plink-1.07-r1.ebuild
22:	lapack? ( virtual/lapack )"

sci-biology/plink/plink-1.90_pre140514.ebuild
23:	virtual/lapack

dev-lang/R/R-3.6.0.ebuild
35:	lapack? ( virtual/lapack:0 )

dev-lang/R/R-3.5.3.ebuild
35:	lapack? ( virtual/lapack:0 )

dev-lang/R/R-3.4.1.ebuild
34:	lapack? ( virtual/lapack:0 )

sys-cluster/hpl/hpl-2.0-r3.ebuild
19:	virtual/lapack

dev-lang/julia/julia-1.1.0.ebuild
55:	virtual/lapack"

dev-lang/julia/julia-9999.ebuild
46:	virtual/lapack"

dev-lang/julia/julia-1.1.1.ebuild
55:	virtual/lapack"

app-accessibility/sphinxbase/sphinxbase-0.8.ebuild
25:	lapack? ( virtual/lapack )

sci-geosciences/grass/grass-7.4.4.ebuild
42:	lapack? ( virtual/lapack )

media-gfx/hugin/hugin-2019.0.0.ebuild
43:	lapack? ( virtual/blas virtual/lapack )

media-gfx/hugin/hugin-9999.ebuild
45:	lapack? ( virtual/blas virtual/lapack )

media-gfx/greycstoration/greycstoration-2.9-r2.ebuild
23:	lapack? ( virtual/lapack )

sci-mathematics/octave/octave-4.4.0.ebuild
25:	virtual/lapack

sci-mathematics/octave/octave-4.2.2.ebuild
25:	virtual/lapack

sci-mathematics/octave/octave-4.4.1.ebuild
25:	virtual/lapack

sci-mathematics/Macaulay2/Macaulay2-1.8.2.1-r1.ebuild
45:	virtual/lapack

sci-mathematics/jags/jags-3.4.0.ebuild
21:	virtual/lapack"

sci-mathematics/jags/jags-4.2.0.ebuild
21:	virtual/lapack"

sci-mathematics/jags/jags-4.1.0.ebuild
21:	virtual/lapack"

sci-mathematics/jags/jags-4.0.0.ebuild
21:	virtual/lapack"
