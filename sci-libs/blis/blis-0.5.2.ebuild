# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="BLAS-like Library Instantiation Software Framework"
HOMEPAGE="https://github.com/flame/blis"
SRC_URI="https://github.com/flame/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="~amd64"
IUSE="openmp pthread static-libs blas cblas doc"
REQUIRED_USE="?? ( openmp pthread )"

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

src_configure () {
	set +x
	local BLIS_FLAGS=()
	use static-libs && \
		BLIS_FLAGS+=( --enable-static ) || BLIS_FLAGS+=( --disable-static )
	use blas && \
		BLIS_FLAGS+=( --enable-blas ) || BLIS_FLAGS+=( --disable-blas )
	use cblas && \
		BLIS_FLAGS+=( --enable-cblas ) || BLIS_FLAGS+=( --disable-cblas )
	if use openmp; then
		BLIS_FLAGS+=( -t openmp )
	elif use pthread; then
		BLIS_FLAGS+=( -t pthreads )
	else
		BLIS_FLAGS+=( -t no )
	fi
	./configure \
		--enable-verbose-make \
		--prefix=/usr \
		--libdir=/usr/lib64/ \
		${BLIS_FLAGS[@]} \
		--enable-shared auto
}

src_install () {
	emake DESTDIR="${D}" install
	use doc && dodoc README.md docs/*.md
}
