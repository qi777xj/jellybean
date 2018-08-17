# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="A screen magnifier"
HOMEPAGE="ftp://sunsite.unc.edu/pub/linux/libs/X/"
SRC_URI="https://www.ibiblio.org/pub/Linux/X11/libs/xzoom-0.3.tgz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	x11-libs/libXt
	x11-libs/libXext
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PF}"

src_prepare(){
	eapply_user
	eapply "${FILESDIR}/${PF}.patch"
	xmkmf
	sed -i "s@-O2@$CFLAGS@" ./Makefile
}

src_install(){
	emake DESTDIR="${D}" install
}
