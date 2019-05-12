# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="BLAS-like Library Instantiation Software Framework"
HOMEPAGE="https://github.com/flame/blis"
SRC_URI="https://github.com/flame/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="~amd64"
IUSE="openmp pthread static-libs blas cblas doc 64bit-index"
REQUIRED_USE="?? ( openmp pthread )"

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

src_configure () {
	local BLIS_FLAGS=()
	if use openmp; then
		BLIS_FLAGS+=( -t openmp )
	elif use pthread; then
		BLIS_FLAGS+=( -t pthreads )
	else
		BLIS_FLAGS+=( -t no )
	fi
	use 64bit-index && BLIS_FLAGS+=( -b 64 -i 64 )
	# This is not a autotools configure file. We don't use econf here.
	./configure \
		--enable-verbose-make \
		--prefix=/usr \
		--libdir=/usr/lib64/ \
		$(use_enable static-libs static) \
		$(use_enable blas) \
		$(use_enable cblas) \
		${BLIS_FLAGS[@]} \
		--enable-shared auto
}

src_install () {
	emake DESTDIR="${D}" install
	use doc && dodoc README.md docs/*.md
}
