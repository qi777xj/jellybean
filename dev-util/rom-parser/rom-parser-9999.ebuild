# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="The tool for parsing ROM"
HOMEPAGE="https://github.com/awilliam/rom-parser"
EGIT_REPO_URI="https://github.com/awilliam/rom-parser.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

src_compile() {
	emake
}

src_install() {
	dobin rom-parser
	dobin rom-fixer
}
