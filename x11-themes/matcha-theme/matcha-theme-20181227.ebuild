# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

URL="https://www.gnome-look.org/p/1187179"

DESCRIPTION="Matcha is a flat Design theme for GTK 3, GTK 2 and Gnome-Shell"
HOMEPAGE="https://www.gnome-look.org/p/1187179"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cinnamon gnome-shell +gtk2 +gtk3 mate openbox xfce"

DEPEND="gtk3? ( >=x11-libs/gtk+-3.14:3
	virtual/pkgconfig )
	net-misc/curl
	"
RDEPEND="gtk2? ( x11-themes/gnome-themes-standard
	x11-themes/gtk-engines-murrine )
	net-misc/curl
	"

S="${WORKDIR}"

src_unpack() {
	local HASH_TIME=($(curl -s "$URL" | grep -e "hash =" -e "timetamp =" | sed "s/.*= '\(.*\)';/\1/"))
	cd "$S"
	curl https://dl.opendesktop.org/api/files/downloadfile/id/1545889799/s/${HASH_TIME[0]}/t/${HASH_TIME[1]}/Matcha-sea.tar.xz -o Matcha-sea.tar.xz
	curl https://dl.opendesktop.org/api/files/downloadfile/id/1545889772/s/${HASH_TIME[0]}/t/${HASH_TIME[1]}/Matcha-azul.tar.xz -o Matcha-azul.tar.xz
	curl https://dl.opendesktop.org/api/files/downloadfile/id/1545889792/s/${HASH_TIME[0]}/t/${HASH_TIME[1]}/Matcha-aliz.tar.xz -o Matcha-aliz.tar.xz
	curl https://dl.opendesktop.org/api/files/downloadfile/id/1545889786/s/${HASH_TIME[0]}/t/${HASH_TIME[1]}/Matcha-dark-sea.tar.xz -o Matcha-dark-sea.tar.xz
	curl https://dl.opendesktop.org/api/files/downloadfile/id/1545889850/s/${HASH_TIME[0]}/t/${HASH_TIME[1]}/Matcha-dark-azul.tar.xz -o Matcha-dark-azul.tar.xz
	curl https://dl.opendesktop.org/api/files/downloadfile/id/1545889794/s/${HASH_TIME[0]}/t/${HASH_TIME[1]}/Matcha-dark-aliz.tar.xz -o Matcha-dark-aliz.tar.xz
	unpack "${S}"/*.tar.xz
}

src_prepare() {
	default
	if use openbox; then
		sed -i 's/\(menu.items.text.color:\).*$/\1 #d3c2c5/; s/\(menu.border.color:\).*$/\1 #2d3036/;
      s/\(menu.seperator.color:\).*$/\1 #32353b/' Matcha-dark-*/openbox-3/themerc

		sed -i 's/\(menu.items.bg.color:\).*$/\1 #1f2729/' Matcha-dark-sea/openbox-3/themerc
		sed -i 's/\(menu.items.bg.color:\).*$/\1 #1b1d24/' Matcha-dark-azul/openbox-3/themerc
		sed -i 's/\(menu.items.bg.color:\).*$/\1 #222222/' Matcha-dark-aliz/openbox-3/themerc

		sed -i 's/#2f9b85/#2eb398/Ig' Matcha{,-dark}-sea/openbox-3/themerc
		sed -i 's/#2f9b85/#3498db/Ig' Matcha{,-dark}-azul/openbox-3/themerc
		sed -i 's/#2f9b85/#f0544c/Ig' Matcha{,-dark}-aliz/openbox-3/themerc
		sed -i 's/#1b2224/#1b1d24/Ig' Matcha{,-dark}-azul/openbox-3/themerc
		sed -i 's/#1b2224/#222222/Ig' Matcha{,-dark}-aliz/openbox-3/themerc
	fi
	! use cinnamon && rm -r */cinnamon
	! use gnome-shell && rm -r */gnome-shell
	! use gtk2 && rm -r */gtk-2.0
	! use gtk3 && rm -r */gtk-3.0
	! use openbox && rm -r */openbox-3
	! use xfce && rm -r */xfwm4
	! use mate && rm -r */metacity-1
	rm -r */unity
}

src_install() {
	insinto /usr/share/themes
	doins -r Matcha-sea
	doins -r Matcha-azul
	doins -r Matcha-aliz
	doins -r Matcha-dark-sea
	doins -r Matcha-dark-azul
	doins -r Matcha-dark-aliz
}
