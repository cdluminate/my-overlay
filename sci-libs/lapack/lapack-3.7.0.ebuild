# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
CMAKE_MAKEFILE_GENERATOR=emake
inherit cmake-utils
#inherit eutils fortran-2 cmake-utils multilib flag-o-matic toolchain-funcs

DESCRIPTION="BLAS,CBLAS,LAPACK,LAPACKE reference implementations"
HOMEPAGE="http://www.netlib.org/lapack/"
SRC_URI="http://www.netlib.org/${PN}/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"
IUSE="cblas lapacke doc"

RDEPEND="
	app-eselect/eselect-blas
	app-eselect/eselect-cblas
	app-eselect/eselect-lapack
	doc? ( app-doc/blas-docs )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

#PATCHES=( "${FILESDIR}/lapack-reference-${LPV}-fix-build-system.patch" )

src_configure() {
	local mycmakeargs=(
		-DCBLAS=ON
		-DLAPACKE=ON
		-DCMAKE_INSTALL_PREFIX=/usr
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_STATIC_LIBS=ON
	)
	cmake-utils_src_configure
}

src_compile () {
	cmake-utils_src_compile
}

src_install () {
	cmake-utils_src_install

	mkdir -p ${ED}/usr/$(get_libdir)/blas/reference/
	mv -v ${ED}/usr/$(get_libdir)/libblas.so* ${ED}/usr/$(get_libdir)/blas/reference/
	eselect blas add "$(get_libdir)" "${FILESDIR}/eselect.blas.reference" reference

	mkdir -p ${ED}/usr/$(get_libdir)/cblas/reference/
	mv -v ${ED}/usr/$(get_libdir)/libcblas.so* ${ED}/usr/$(get_libdir)/cblas/reference/
	eselect cblas add "$(get_libdir)" "${FILESDIR}/eselect.cblas.reference" reference

	mkdir -p ${ED}/usr/$(get_libdir)/lapack/reference/
	mv -v ${ED}/usr/$(get_libdir)/liblapack.so* ${ED}/usr/$(get_libdir)/lapack/reference/
	eselect lapack add "$(get_libdir)" "${FILESDIR}/eselect.lapack.reference" reference
}

pkg_postinst () {
	eselect blas set reference
	local current_blas=$(eselect blas show | cut -d' ' -f2)
	elog "Current eselect: blas -> [${current_blas}]."

	eselect cblas set reference
	local current_cblas=$(eselect cblas show | cut -d' ' -f2)
	elog "Current eselect: cblas -> [${current_cblas}]."

	eselect lapack set reference
	local current_lapack=$(eselect lapack show | cut -d' ' -f2)
	elog "Current eselect: lapack -> [${current_lapack}]."
}

#src_prepare() {
#	cmake-utils_src_prepare
#
#	ESELECT_PROF=reference
#
#	cp "${FILESDIR}"/eselect.blas.reference-r1 "${T}"/eselect.blas.reference || die
#	sed -i -e "s:/usr:${EPREFIX}/usr:" "${T}"/eselect.blas.reference || die
#	if [[ ${CHOST} == *-darwin* ]] ; then
#		sed -i -e 's/\.so\([\.0-9]\+\)\?/\1.dylib/g' \
#			"${T}"/eselect.blas.reference || die
#	fi
#}
#
#src_test() {
#	local BUILD_DIR="${WORKDIR}/${P}_build/BLAS"
#	cmake-utils_src_test
#}
#
#src_install() {
#	cmake-utils_src_install -C BLAS
#
#	mkdir -p "${ED}/usr/$(get_libdir)/blas/reference" || die
#	mv "${ED}/usr/$(get_libdir)"/lib* "${ED}/usr/$(get_libdir)/pkgconfig"/* \
#		"${ED}/usr/$(get_libdir)/blas/reference" || die
#	if [[ ${CHOST} == *-darwin* ]] ; then
#		# modify install_names accordingly, bug #605214
#		local lib
#		for lib in "${ED}"/usr/$(get_libdir)/blas/reference/*.dylib ; do
#			install_name_tool -id "${lib#${D%/}}" "${lib}"
#		done
#	fi
#	rmdir "${ED}/usr/$(get_libdir)/pkgconfig" || die
#
#	eselect blas add $(get_libdir) "${T}"/eselect.blas.reference ${ESELECT_PROF}
#}
#
#pkg_postinst() {
#	local p=blas
#	local current_lib=$(eselect ${p} show | cut -d' ' -f2)
#	if [[ ${current_lib} == ${ESELECT_PROF} || -z ${current_lib} ]]; then
#		# work around eselect bug #189942
#		local configfile="${EROOT}"/etc/env.d/${p}/$(get_libdir)/config
#		[[ -e ${configfile} ]] && rm -f ${configfile}
#		eselect ${p} set ${ESELECT_PROF}
#		elog "${p} has been eselected to ${ESELECT_PROF}"
#	else
#		elog "Current eselected ${p} is ${current_lib}"
#		elog "To use ${p} ${ESELECT_PROF} implementation, you have to issue (as root):"
#		elog "\t eselect ${p} set ${ESELECT_PROF}"
#	fi
#}
