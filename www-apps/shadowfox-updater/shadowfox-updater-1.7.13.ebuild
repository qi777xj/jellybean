# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build golang-vcs-snapshot

DESCRIPTION="An auto-updater for ShadowFox"
HOMEPAGE="https://github.com/SrKomodo/shadowfox-updater"
EGO_PN="github.com/SrKomodo/shadowfox-updater"
SRC_URI="https://github.com/SrKomodo/shadowfox-updater/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${P}"

src_prepare() {
	default
}

src_compile() {
	pushd src/${EGO_PN} || die
	GOPATH="${S}"
	go get
	go build -o ${PN} || die
	popd || die
}

src_install() {
	pushd src/${EGO_PN} || die
	dobin shadowfox-updater
	popd || die
}
