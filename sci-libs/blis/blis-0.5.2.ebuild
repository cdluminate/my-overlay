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
IUSE="openmp pthread static-libs blas cblas doc 64bit-index"
REQUIRED_USE="?? ( openmp pthread )"

RDEPEND=(
    "dev-lang/python"
	"app-eselect/eselect-blas"
	"!app-eselect/eselect-cblas"
)
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-rpath.patch"
	"${FILESDIR}/${P}-blas-provider.patch"
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
		$(use_enable cblas) \
		${BLIS_FLAGS[@]} \
		--enable-shared \
		$confname
}

src_install () {
	default
	use doc && dodoc README.md docs/*.md

	if use blas; then
		mkdir -p ${ED}/usr/$(get_libdir)/blas/blis/
		install -Dm0644 lib/*/${DEB_LIBBLAS} ${ED}/usr/$(get_libdir)/blas/blis/
		ln -s ${DEB_LIBBLAS} ${ED}/usr/$(get_libdir)/blas/blis/libblas.so
		install -Dm0644 "${FILESDIR}/blas.pc" ${ED}/usr/$(get_libdir)/blas/blis/

		cat ${FILESDIR}/eselect.blas.blis > ${T}/eselect.blas.blis
	fi

	if use cblas; then
		mkdir -p ${ED}/usr/$(get_libdir)/blas/blis/
		install -Dm0644 lib/*/${DEB_LIBCBLAS} ${ED}/usr/$(get_libdir)/blas/blis/
		ln -s ${DEB_LIBCBLAS} ${ED}/usr/$(get_libdir)/blas/blis/libcblas.so
		install -Dm0644 "${FILESDIR}/cblas.pc" ${ED}/usr/$(get_libdir)/blas/blis/

		cat ${FILESDIR}/eselect.cblas.blis >> ${T}/eselect.blas.blis
	fi

	if use blas || use cblas; then
		eselect blas add "$(get_libdir)" "${T}/eselect.blas.blis" "${PN}"
	fi
}

pkg_postinst() {
	# check blas
	if ! (use blas || use cblas); then return; fi
	local current_blas=$(eselect blas show | cut -d' ' -f2)
	if [[ ${current_blas} == blis || -z ${current_blas} ]]; then
		# work around eselect bug #189942
		local configfile="${EROOT}"/etc/env.d/blas/$(get_libdir)/config
		[[ -e ${configfile} ]] && rm -f ${configfile}
		eselect blas set "${PN}"
		elog "Current eselect: blas -> [${current_blas}]."
	else
		elog "Current eselect: blas -> [${current_blas}]."
		elog "To use blas [${PN}] implementation, you have to issue (as root):"
		elog "\t eselect blas set ${PN}"
	fi
}
