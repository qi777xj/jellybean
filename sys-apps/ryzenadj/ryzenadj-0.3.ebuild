# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

MY_PN="RyzenAdj"

DESCRIPTION="Adjust power management settings for Mobile Raven Ridge Ryzen Processors"
HOMEPAGE="https://github.com/FlyGoat/RyzenAdj"
SRC_URI="https://github.com/FlyGoat/RyzenAdj/archive/v${PV}-rel.tar.gz"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}-rel"

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	dobin "${WORKDIR}/${P}_build/ryzenadj"
}
