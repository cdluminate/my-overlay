# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit eutils

DESCRIPTION="BLAS-like Library Instantiation Software Framework"
HOMEPAGE="https://github.com/flame/blis"
SRC_URI="https://github.com/flame/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc64"
IUSE="openmp pthread serial static-libs blas doc 64bit-index"
REQUIRED_USE="?? ( openmp pthread serial )"

RDEPEND=(
	"!app-eselect/eselect-cblas"
	">=app-eselect/eselect-blas-0.2"
)
DEPEND="${RDEPEND}
	dev-lang/python
"

PATCHES=(
	"${FILESDIR}/${P}-rpath.patch"
	"${FILESDIR}/${P}-blas-provider.patch"
	"${FILESDIR}/${P}-gh313.patch"
)

export DEB_LIBBLAS=libblas.so.3
export DEB_LIBCBLAS=libcblas.so.3
export LDS_BLAS="${FILESDIR}/blas.lds"
export LDS_CBLAS="${FILESDIR}/cblas.lds"

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
	# This is not an autotools configure file. We don't use econf here.
	./configure \
		--enable-verbose-make \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		$(use_enable static-libs static) \
		$(use_enable blas) \
		$(use_enable blas cblas) \
		${BLIS_FLAGS[@]} \
		--enable-shared \
		$confname
}

src_test () {
	emake check
}

src_install () {
	default
	use doc && dodoc README.md docs/*.md

	if use blas; then
		mkdir -p ${ED}/usr/$(get_libdir)/blas/blis/
		install -Dm0644 lib/*/${DEB_LIBBLAS} ${ED}/usr/$(get_libdir)/blas/blis/
		install -Dm0644 lib/*/${DEB_LIBCBLAS} ${ED}/usr/$(get_libdir)/blas/blis/
		ln -s ${DEB_LIBBLAS} ${ED}/usr/$(get_libdir)/blas/blis/libblas.so
		ln -s ${DEB_LIBCBLAS} ${ED}/usr/$(get_libdir)/blas/blis/libcblas.so
		install -Dm0644 "${FILESDIR}/blas.pc" ${ED}/usr/$(get_libdir)/blas/blis/
		install -Dm0644 "${FILESDIR}/cblas.pc" ${ED}/usr/$(get_libdir)/blas/blis/
	fi
}

pkg_postinst() {
	local libdir=$(get_libdir) me="blis"
	if use 64bit-index; then return; fi
	if ! (use blas); then return; fi

	# check blas
	eselect blas add ${libdir} ${me}
	local current_blas=$(eselect blas show ${libdir})
	if [[ ${current_blas} == blis || -z ${current_blas} ]]; then
		eselect blas set ${libdir} ${me}
		elog "Current eselect: BLAS/CBLAS ($libdir) -> [${current_blas}]."
	else
		elog "Current eselect: BLAS/CBLAS ($libdir) -> [${current_blas}]."
		elog "To use blas [${me}] implementation, you have to issue (as root):"
		elog "\t eselect blas set ${libdir} ${me}"
	fi
}
