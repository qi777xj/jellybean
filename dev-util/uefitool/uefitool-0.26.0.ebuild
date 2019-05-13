# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="UEFI firmware image viewer and editor"
HOMEPAGE="https://github.com/LongSoft/UEFITool"
SRC_URI="https://github.com/LongSoft/UEFITool/archive/${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/UEFITool-${PV}"

src_configure() {
	eqmake5
}

src_install() {
	dobin UEFITool
}
