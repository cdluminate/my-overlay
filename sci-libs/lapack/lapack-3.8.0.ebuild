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
IUSE="cblas lapacke doc"
# TODO: static-libs 64bit-index

RDEPEND="
	app-eselect/eselect-blas
	!app-eselect/eselect-cblas
	app-eselect/eselect-lapack
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
		-DCBLAS=$(usex cblas)
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

	# mangle BLAS installation path
	mkdir -p ${ED}/usr/$(get_libdir)/blas/reference/
	mv -v ${ED}/usr/$(get_libdir)/libblas.so* ${ED}/usr/$(get_libdir)/blas/reference/
	mv -v ${ED}/usr/$(get_libdir)/pkgconfig/blas.pc ${ED}/usr/$(get_libdir)/blas/reference/

	# mangle CBLAS installation path
	if use cblas; then
		mkdir -p ${ED}/usr/$(get_libdir)/blas/reference/
		mv -v ${ED}/usr/$(get_libdir)/libcblas.so* ${ED}/usr/$(get_libdir)/blas/reference/
		mv -v ${ED}/usr/$(get_libdir)/pkgconfig/cblas.pc ${ED}/usr/$(get_libdir)/blas/reference/
		mv -v ${ED}/usr/include/cblas* ${ED}/usr/$(get_libdir)/blas/reference/
	fi

	# register blas (cblas) eselect switch
	cat ${FILESDIR}/eselect.blas.reference > ${T}/eselect.blas.reference
	use cblas && (cat ${FILESDIR}/eselect.cblas.reference >> ${T}/eselect.blas.reference)
	eselect blas add "$(get_libdir)" "${T}/eselect.blas.reference" reference

	# mangle LAPACK installation path
	mkdir -p ${ED}/usr/$(get_libdir)/lapack/reference/
	mv -v ${ED}/usr/$(get_libdir)/liblapack.so* ${ED}/usr/$(get_libdir)/lapack/reference/
	mv -v ${ED}/usr/$(get_libdir)/pkgconfig/lapack.pc ${ED}/usr/$(get_libdir)/lapack/reference/

	# register lapack eselect switch
	eselect lapack add "$(get_libdir)" "${FILESDIR}/eselect.lapack.reference" reference
}

pkg_postinst () {
	local me=reference

	# check eselect-blas
	local current_blas=$(eselect blas show | cut -d' ' -f2)
	if [[ ${current_blas} == ${me} || -z ${current_blas} ]]; then
		eselect blas set ${me}
		elog "Current eselect: blas -> [${current_blas}]."
	else
		elog "Current eselect: blas -> [${current_blas}]."
		elog "To use blas [${me}] implementation, you have to issue (as root):"
		elog "\t eselect blas set ${me}"
	fi

	# check eselect-lapack
	local current_lapack=$(eselect lapack show | cut -d' ' -f2)
	if [[ ${current_lapack} == ${me} || -z ${current_lapack} ]]; then
		eselect lapack set ${me}
		elog "Current eselect: lapack -> [${current_lapack}]."
	else
		elog "Current eselect: lapack -> [${current_lapack}]."
		elog "To use lapack [${me}] implementation, you have to issue (as root):"
		elog "\t eselect lapack set ${me}"
	fi
}
