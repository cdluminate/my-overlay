# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Virtual for FORTRAN 77 BLAS implementation"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

RDEPEND="|| (
		sci-libs/lapack
		sci-libs/blis
		>=sci-libs/mkl-9.1.023
	)
	!sci-libs/blas-reference
	"
