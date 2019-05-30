# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Virtual for FORTRAN 77 BLAS implementation"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"

RDEPEND="|| (
		sci-libs/lapack
		sci-libs/blis
		>=sci-libs/mkl-9.1.023
	)
	!sci-libs/blas-reference
	"
