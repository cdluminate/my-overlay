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
KEYWORDS="~amd64 ~ppc64"
IUSE="lapacke doc"
# TODO: static-libs 64bit-index

RDEPEND="
	!app-eselect/eselect-blas
	!app-eselect/eselect-cblas
	!app-eselect/eselect-lapack
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

	# Create private lib directory for eselect (ld.so.conf)
	mkdir -p ${ED}/usr/$(get_libdir)/blas/reference/
	ln -s ../../libblas.so    ${ED}/usr/$(get_libdir)/blas/reference/libblas.so
	ln -s ../../libblas.so.3  ${ED}/usr/$(get_libdir)/blas/reference/libblas.so.3
	ln -s ../../libcblas.so   ${ED}/usr/$(get_libdir)/blas/reference/libcblas.so
	ln -s ../../libcblas.so.3 ${ED}/usr/$(get_libdir)/blas/reference/libcblas.so.3

	mkdir -p ${ED}/usr/share/eselect/modules/
	install -vm0644 ${FILESDIR}/blas.eselect ${ED}/usr/share/eselect/modules/blas.eselect
}

#pkg_postinst () {
#	local me=reference
#
#	# check eselect-blas
#	local current_blas=$(eselect blas show | cut -d' ' -f2)
#	if [[ ${current_blas} == ${me} || -z ${current_blas} ]]; then
#		eselect blas set ${me}
#		elog "Current eselect: blas -> [${current_blas}]."
#	else
#		elog "Current eselect: blas -> [${current_blas}]."
#		elog "To use blas [${me}] implementation, you have to issue (as root):"
#		elog "\t eselect blas set ${me}"
#	fi
#
#	# check eselect-lapack
#	local current_lapack=$(eselect lapack show | cut -d' ' -f2)
#	if [[ ${current_lapack} == ${me} || -z ${current_lapack} ]]; then
#		eselect lapack set ${me}
#		elog "Current eselect: lapack -> [${current_lapack}]."
#	else
#		elog "Current eselect: lapack -> [${current_lapack}]."
#		elog "To use lapack [${me}] implementation, you have to issue (as root):"
#		elog "\t eselect lapack set ${me}"
#	fi
#}
