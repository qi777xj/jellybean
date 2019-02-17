# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font

MY_PN="D2Coding"

DESCRIPTION="Korean monospace font based on NanumBarunGothic which is distributed by NHN"
HOMEPAGE="https://github.com/naver/d2codingfont"
SRC_URI="https://github.com/naver/d2codingfont/releases/download/VER${PV}/D2Coding-Ver${PV}-20180524.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

RESTRICT="strip binchecks"

DEPEND="app-arch/unzip"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}"
FONT_S="${WORKDIR}/${MY_PN}"

FONT_SUFFIX="ttf"
