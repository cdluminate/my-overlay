# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="BLAS-like Library Instantiation Software Framework"
HOMEPAGE="https://github.com/flame/blis"
SRC_URI="https://github.com/flame/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc64"
IUSE="openmp pthread static-libs blas cblas doc 64bit-index"
REQUIRED_USE="?? ( openmp pthread )"

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-rpath.patch"
	"${FILESDIR}/${P}-blas-provider.patch"
)

export DEB_LIBBLAS=libblas.so.3
export DEB_LIBCBLAS=libcblas.so.3

src_configure () {
	local BLIS_FLAGS=()
	local confname
	# determine flags
	if use openmp; then
		BLIS_FLAGS+=( -t openmp )
	elif use pthread; then
		BLIS_FLAGS+=( -t pthreads )
	else
		BLIS_FLAGS+=( -t no )
	fi
	use 64bit-index && BLIS_FLAGS+=( -b 64 -i 64 )
	# determine config name
	case "${ARCH}" in
		"x86" | "amd64")
			confname=auto ;;
		"ppc64")
			confname=generic ;;
		*)
			confname=generic ;;
	esac
	# This is not a autotools configure file. We don't use econf here.
	./configure \
		--enable-verbose-make \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		$(use_enable static-libs static) \
		$(use_enable blas) \
		$(use_enable cblas) \
		${BLIS_FLAGS[@]} \
		--enable-shared \
		$confname
}

src_install () {
	default
	use doc && dodoc README.md docs/*.md

	mkdir -p ${ED}/usr/$(get_libdir)/blas/blis/
	install -Dm0644 lib/*/${DEB_LIBBLAS} ${ED}/usr/$(get_libdir)/blas/blis/
	ln -s ${DEB_LIBBLAS} ${ED}/usr/$(get_libdir)/blas/blis/libblas.so
	install -Dm0644 "${FILESDIR}/blas.pc" ${ED}/usr/$(get_libdir)/blas/blis/
	eselect blas add "$(get_libdir)" "${FILESDIR}/eselect.blas.blis" "${PN}"

	install -Dm0644 lib/*/${DEB_LIBCBLAS} ${ED}/usr/$(get_libdir)/blas/blis/
	ln -s ${DEB_LIBCBLAS} ${ED}/usr/$(get_libdir)/blas/blis/libcblas.so
	eselect cblas add "$(get_libdir)" "${FILESDIR}/eselect.cblas.blis" "${PN}"
}
