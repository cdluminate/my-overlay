# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Virtual for LAPACK C implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc64"
IUSE="int64"

RDEPEND="
	|| (
		sci-libs/lapack[lapacke]
	)
	"
DEPEND=""
