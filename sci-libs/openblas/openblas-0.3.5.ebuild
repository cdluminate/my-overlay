# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Optimized BLAS library based on GotoBLAS2"
HOMEPAGE="http://xianyi.github.com/OpenBLAS/"
SRC_URI="https://github.com/xianyi/OpenBLAS/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="dynamic openmp pthread static-libs virtual-blas virtual-lapack"

RDEPEND="
>=app-eselect/eselect-blas-0.2
>=app-eselect/eselect-lapack-0.2
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

openblas_flags() {
	local flags=()
	use dynamic && \
		flags+=( DYNAMIC_ARCH=1 TARGET=GENERIC NUM_THREADS=64 NO_AFFINITY=1 )
	if use openmp; then
		flags+=( USE_THREAD=1 USE_OPENMP=0 )
	elif use pthread; then
		flags+=( USE_THREAD=1 USE_OPENMP=1 )
	else
		flags+=( USE_THREAD=0 ) # serial
	fi
	flags+=( PREFIX="/usr" DESTDIR="${ED}")
	flags+=( OPENBLAS_INCLUDE_DIR='$(PREFIX)'/include/${PN} )
	flags+=( OPENBLAS_LIBRARY_DIR='$(PREFIX)'/$(get_libdir) )
	echo "${flags[@]}"
}

src_unpack () {
	default
	find "${WORKDIR}" -maxdepth 1 -type d -name \*OpenBLAS\* && \
		mv "${WORKDIR}"/*OpenBLAS* "${S}" || die
}

src_compile () {
	emake $(openblas_flags)
}

src_install () {
	emake install $(openblas_flags)

	if use virtual-blas; then
		mkdir -p ${ED}/usr/$(get_libdir)/blas/openblas/
		ln -s ../../libopenblas.so.0 ${ED}/usr/$(get_libdir)/blas/openblas/libblas.so.3
		ln -s ../../libopenblas.so.0 ${ED}/usr/$(get_libdir)/blas/openblas/libcblas.so.3
		ln -s libblas.so.3           ${ED}/usr/$(get_libdir)/blas/openblas/libblas.so
		ln -s libcblas.so.3          ${ED}/usr/$(get_libdir)/blas/openblas/libcblas.so
	fi
	if use virtual-lapack; then
		mkdir -p ${ED}/usr/$(get_libdir)/lapack/openblas/
		ln -s ../../libopenblas.so.0 ${ED}/usr/$(get_libdir)/lapack/openblas/liblapack.so.3
		ln -s liblapack.so.3         ${ED}/usr/$(get_libdir)/lapack/openblas/liblapack.so
	fi
}

pkg_postinst () {
	use virtual-blas && \
		eselect blas add $(get_libdir) \
			${EROOT}/usr/$(get_libdir)/blas/openblas openblas
	use virtual-lapack && \
		eselect lapack add $(get_libdir) \
			${EROOT}/usr/$(get_libdir)/lapack/openblas openblas
}
