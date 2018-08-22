# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils

DESCRIPTION="Graphical User Interface for CryptoBridge DEX"
HOMEPAGE="https://crypto-bridge.org/"
SRC_URI="https://github.com/CryptoBridge/cryptobridge-ui/releases/download/v${PV}/${PN^}_${PV}_amd64.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack(){
	unpack ${PN^}_${PV}_amd64.deb
	tar xpf data.tar.xz
}

DESTPATH="opt/CryptoBridge"
S=${WORKDIR}

QA_PREBUILT="
	${DESTPATH}/cryptobridge
	${DESTPATH}/libffmpeg.so
	${DESTPATH}/libnode.so
"

src_install(){
	dodir /${DESTPATH}
	into /${DESTPATH}
	exeinto /${DESTPATH}
	doexe ${DESTPATH}/cryptobridge
	insinto /${DESTPATH}
	doins -r ${DESTPATH}/locales
	doins -r ${DESTPATH}/resources
	doins ${DESTPATH}/*.so
	doins ${DESTPATH}/*.pak
	doins ${DESTPATH}/*.dat
	doins ${DESTPATH}/*.html
	doins ${DESTPATH}/*.txt
	doins ${DESTPATH}/*.bin
	insinto /usr/share/applications
	doins usr/share/applications/*.desktop
	dodoc usr/share/doc/cryptobridge/*.gz
	dodir /usr/share/icons/hicolor/0x0/apps
	insinto /usr/share/icons/hicolor/0x0/apps
	doins usr/share/icons/hicolor/0x0/apps/*.png
	dosym /${DESTPATH}/cryptobridge /usr/bin/cryptobridge
}

pkg_postinst(){
	gnome2_icon_cache_update
}
