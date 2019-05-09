# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="BLAS-like Library Instantiation Software Framework "
HOMEPAGE="https://github.com/flame/blis"
SRC_URI="https://github.com/flame/blis/archive/0.5.2.tar.gz"

LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure () {
	./configure --enable-verbose-make --prefix=/usr --enable-cblas \
		--enable-static --enable-shared --libdir=/usr/lib64/ auto
}

src_install () {
	emake DESTDIR="${D}" install
}
