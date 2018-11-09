# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN/-bin/}"

DESCRIPTION="Analysis interface for Leela Zero"
HOMEPAGE="https://github.com/featurecat/lizzie"
SRC_URI="https://github.com/featurecat/${MY_PN}/releases/download/${PV}/${MY_PN^}.${PV}.Mac-Linux.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	=games-board/leela-zero-9999
	app-arch/unzip
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN^}"

src_unpack() {
	cp "${DISTDIR}/${P}.zip" "${WORKDIR}/${P}.zip"
	cd "${WORKDIR}"
	unzip "${P}.zip"
}

src_prepare() {
	default
	rm "${S}"/network.gz
}

src_install() {
	dodir /opt/lizzie
	insinto /opt/lizzie
	doins -r "${S}"/*
	dosym /usr/bin/leelaz /opt/lizzie/leelaz
	dosym /usr/share/leela-zero/best-network /opt/lizzie/network.gz
	newbin "${FILESDIR}/${P}.sh" lizzie
	fperms +x /usr/bin/lizzie
	fperms +x /opt/lizzie/lizzie.jar
}
