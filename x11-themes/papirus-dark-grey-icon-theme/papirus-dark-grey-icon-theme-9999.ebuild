# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="The dark grey forked version of Papirus Icon Theme"
HOMEPAGE="https://github.com/Intika-KDE-Plasmoids/plasmoid-papirus-dark-grey-icon-theme"

EGIT_REPO_URI="https://github.com/Intika-KDE-Plasmoids/plasmoid-papirus-dark-grey-icon-theme.git"

LICENSE="GPL-3.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${P}"

src_install(){
	insinto /usr/share/icons
	doins -r Papirus-Dark-Grey
}
