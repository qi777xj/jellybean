# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Leela (Zero) integration with Sabaki."
HOMEPAGE="https://github.com/SabakiHQ/LeelaSabaki"
SRC_URI="https://github.com/SabakiHQ/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	games-board/sabaki
	games-board/leela-zero
	net-libs/nodejs[npm]
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

src_prepare() {
	default
	npm install || die "npm module installation failed"
}

src_compile() {
	npm run build || die "build failed"
}

src_install() {
	dobin "${S}/bin/leelasabaki"
}
