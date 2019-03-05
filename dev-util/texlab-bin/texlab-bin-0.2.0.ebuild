# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN=${PN/-bin/}

DESCRIPTION="A cross-platform implementation of the Language Server Protocol for LaTeX."
HOMEPAGE="https://texlab.netlify.com/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-misc/wget
		virtual/jre"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_prepare() {
	default
	wget https://github.com/efoerster/${MY_PN}/releases/download/v${PV}/${MY_PN}.jar
}

src_install() {
	dodir /opt/${MY_PN}
	insinto /opt/${MY_PN}
	doins "${S}/texlab.jar"
	newbin "${FILESDIR}/${PN}.sh" ${MY_PN}
	fperms +x /usr/bin/${MY_PN}
	fperms -R +x /opt/${MY_PN}
}
