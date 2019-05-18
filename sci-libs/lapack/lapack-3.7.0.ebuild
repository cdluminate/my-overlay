# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="BLAS,CBLAS,LAPACK,LAPACKE reference implementations"
HOMEPAGE="http://www.netlib.org/lapack/"
SRC_URI="http://www.netlib.org/${PN}/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"
IUSE="cblas lapacke"

src_configure () {
	mkdir -p build
	cd build
	cmake .. -DBUILD_SHARED_LIBS=ON -DCBLAS=ON -DLAPACKE=ON
}

src_compile () {
	cd build
	default
}

#CMAKE_MAKEFILE_GENERATOR=emake
#
#inherit eutils fortran-2 cmake-utils multilib flag-o-matic toolchain-funcs
#
#
#RDEPEND="
#	app-eselect/eselect-blas
#	doc? ( app-doc/blas-docs )"
#DEPEND="${RDEPEND}
#	virtual/pkgconfig"
#
#S="${WORKDIR}/${LPN}-${LPV}"
#PATCHES=( "${FILESDIR}/lapack-reference-${LPV}-fix-build-system.patch" )
#
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
#src_configure() {
#	local mycmakeargs=(
#		-Wno-dev
#		-DUSE_OPTIMIZED_BLAS=OFF
#		-DCMAKE_Fortran_FLAGS="$(get_abi_CFLAGS) ${FCFLAGS}"
#		-DBUILD_SHARED_LIBS=ON
#		-DBUILD_STATIC_LIBS=ON
#	)
#
#	cmake-utils_src_configure
#}
#
#src_compile() {
#	cmake-utils_src_compile -C BLAS
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
