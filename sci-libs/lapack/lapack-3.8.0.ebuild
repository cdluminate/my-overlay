# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
CMAKE_MAKEFILE_GENERATOR=emake
inherit cmake-utils

DESCRIPTION="BLAS,CBLAS,LAPACK,LAPACKE reference implementations"
HOMEPAGE="http://www.netlib.org/lapack/"
SRC_URI="http://www.netlib.org/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris"
IUSE="lapacke doc"
# TODO: static-libs 64bit-index

RDEPEND="
	>=app-eselect/eselect-blas-0.2
	>=app-eselect/eselect-lapack-0.2
	!app-eselect/eselect-cblas
	!sci-libs/blas-reference
	!sci-libs/cblas-reference
	!sci-libs/lapack-reference
	!sci-libs/lapacke-reference
	doc? ( app-doc/blas-docs )
	virtual/pkgconfig"
DEPEND="${RDEPEND}
	virtual/fortran"

src_configure() {
	local mycmakeargs=(
		-DCBLAS=ON
		-DLAPACKE=$(usex lapacke)
		-DCMAKE_INSTALL_PREFIX=/usr
		-DBUILD_SHARED_LIBS=ON
	)
	cmake-utils_src_configure
}

src_compile () {
	cmake-utils_src_compile
}

src_install () {
	cmake-utils_src_install

	# Create private lib directory for eselect::blas (ld.so.conf)
	mkdir -p ${ED}/usr/$(get_libdir)/blas/reference/
	ln -s ../../libblas.so    ${ED}/usr/$(get_libdir)/blas/reference/libblas.so
	ln -s ../../libblas.so.3  ${ED}/usr/$(get_libdir)/blas/reference/libblas.so.3
	ln -s ../../libcblas.so   ${ED}/usr/$(get_libdir)/blas/reference/libcblas.so
	ln -s ../../libcblas.so.3 ${ED}/usr/$(get_libdir)/blas/reference/libcblas.so.3

	# Create private lib directory for eselect::lapack (ld.so.conf)
	mkdir -p ${ED}/usr/$(get_libdir)/lapack/reference/
	ln -s ../../liblapack.so    ${ED}/usr/$(get_libdir)/lapack/reference/liblapack.so
	ln -s ../../liblapack.so.3  ${ED}/usr/$(get_libdir)/lapack/reference/liblapack.so.3
}

pkg_postinst () {
	local me=reference libdir=$(get_libdir)

	# check eselect-blas
	eselect blas add ${libdir} ${EROOT}/usr/${libdir}/blas/${me} ${me}
	local current_blas=$(eselect blas show ${libdir} | cut -d' ' -f2)
	if [[ ${current_blas} == ${me} || -z ${current_blas} ]]; then
		eselect blas set ${libdir} ${me}
		elog "Current eselect: BLAS ($libdir) -> [${current_blas}]."
	else
		elog "Current eselect: BLAS ($libdir) -> [${current_blas}]."
		elog "To use blas [${me}] implementation, you have to issue (as root):"
		elog "\t eselect blas set ${libdir} ${me}"
	fi

	# check eselect-lapack
	eselect lapack add ${libdir} ${EROOT}/usr/${libdir}/lapack/${me} ${me}
	local current_lapack=$(eselect lapack show ${libdir} | cut -d' ' -f2)
	if [[ ${current_lapack} == ${me} || -z ${current_lapack} ]]; then
		eselect lapack set ${libdir} ${me}
		elog "Current eselect: LAPACK ($libdir) -> [${current_lapack}]."
	else
		elog "Current eselect: LAPACK ($libdir) -> [${current_lapack}]."
		elog "To use lapack [${me}] implementation, you have to issue (as root):"
		elog "\t eselect lapack set ${libdir} ${me}"
	fi
}

pkg_postrm () {
	eselect blas validate
	eselect lapack validate
}
