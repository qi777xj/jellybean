# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Automagically hide/show a window"
HOMEPAGE="https://github.com/tadly/hideIt.sh"

EGIT_REPO_URI="https://github.com/tadly/hideIt.sh.git"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	x11-apps/xev
	x11-apps/xwininfo
	x11-misc/xdotool
"
RDEPEND="${DEPEND}"

src_install() {
	default
	newbin hideIt.sh hideIt
	fperms 755 /usr/bin/hideIt
}
