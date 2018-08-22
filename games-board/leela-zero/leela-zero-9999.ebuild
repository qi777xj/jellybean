# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Go engine with no human-provided knowledge, modeled after the AlphaGo Zero paper."
HOMEPAGE="https://github.com/gcp/leela-zero"
if [[ ${PV} == "9999" ]]; then
	SCM="git-r3"

	SRC_URI=""
	EGIT_REPO_URI="https://github.com/gcp/leela-zero.git"
	EGIT_BRANCH="next"
else
	SRC_URI="https://github.com/gcp/leela-zero/archive/v${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3.0"
SLOT="0"
IUSE="autogtp ocl-icd"

DEPEND="
	autogtp? ( dev-qt/qtcore:5= )
	autogtp? ( app-arch/gzip:0= )
	net-misc/curl:0
	ocl-icd? ( dev-libs/ocl-icd:0= )
	sys-libs/glibc
	sys-libs/zlib
	sci-libs/openblas
	dev-libs/boost
	virtual/opencl
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-${PV}

pkg_nofetch() {
	einfo
	einfo "This package requiers openblas."
	einfo "Please install gentoo science overlay."
	einfo
}

src_prepare(){
	eapply_user
	if use autogtp ; then
		cd ${S}/autogtp
		qmake -qt5
		cd ${S}
	fi
	cd ${S}
	curl http://zero.sjeng.org/best-network -o best-network
}

src_install(){
	if use autogtp ; then
		cd ${S}/autogtp
		emake
		dobin autogtp
		cd ${S}
	fi
	cd ${S}/src
	emake
	dobin leelaz
	cd ${S}
	insinto /usr/share/leela-zero
	doins best-network
}

pkg_postinst(){
	elog "The weight files is in /usr/share/leela-zero"
}
