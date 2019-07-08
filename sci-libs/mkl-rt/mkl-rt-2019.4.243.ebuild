# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit eutils

DESCRIPTION="Intel Math Kernel Library (Runtime)"
HOMEPAGE="https://software.intel.com/en-us/mkl"
SRC_URI="https://repo.continuum.io/pkgs/main/linux-64/mkl-2019.4-243.tar.bz2 -> ${P}.tar.bz2"

LICENSE="ISSL"
SLOT="0"
KEYWORDS="~amd64"
IUSE="eselect-ldso"

RDEPEND="eselect-ldso? ( !app-eselect/eselect-cblas
                         =app-eselect/eselect-blas-0.2 )"
DEPEND="${RDEPEND}"

src_install () {
	default
	#use doc && dodoc README.md docs/*.md

	#if use eselect-ldso; then
	#	dodir /usr/$(get_libdir)/blas/blis
	#	insinto /usr/$(get_libdir)/blas/blis
	#	doins lib/*/lib{c,}blas.so.3
	#	dosym libblas.so.3 usr/$(get_libdir)/blas/blis/libblas.so
	#	dosym libcblas.so.3 usr/$(get_libdir)/blas/blis/libcblas.so
	#fi
}

pkg_postinst() {
	true
	#use eselect-ldso || return

	#local libdir=$(get_libdir) me="blis"

	## check blas
	#eselect blas add ${libdir} "${EROOT}"/usr/${libdir}/blas/${me} ${me}
	#local current_blas=$(eselect blas show ${libdir})
	#if [[ ${current_blas} == blis || -z ${current_blas} ]]; then
	#	eselect blas set ${libdir} ${me}
	#	elog "Current eselect: BLAS/CBLAS ($libdir) -> [${current_blas}]."
	#else
	#	elog "Current eselect: BLAS/CBLAS ($libdir) -> [${current_blas}]."
	#	elog "To use blas [${me}] implementation, you have to issue (as root):"
	#	elog "\t eselect blas set ${libdir} ${me}"
	#fi
}

pkg_postrm() {
	true
	#use eselect-ldso && eselect blas validate
}

