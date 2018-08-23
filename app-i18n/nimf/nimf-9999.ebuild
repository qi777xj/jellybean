# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools gnome2-utils

DESCRIPTION="Nimf is an input method framework."
HOMEPAGE="https://gitlab.com/nimf-i18n/nimf"
EGIT_REPO_URI="https://gitlab.com/nimf-i18n/nimf.git"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/gtk+:2
	x11-libs/gtk+:3
	dev-libs/libappindicator:3
	dev-qt/qtgui:5
	dev-qt/qtgui:4
	x11-libs/libxkbcommon
	gnome-base/librsvg
	dev-libs/glib:2
	app-i18n/libchewing
	app-i18n/librime
	app-i18n/libhangul
	app-i18n/anthy
	dev-libs/wayland
	dev-libs/wayland-protocols
"

RDEPEND="
	${CDEPEND}
"
DEPEND="
	${CDEPEND}
	dev-util/intltool
	sys-devel/gettext
	x11-base/xorg-proto
"

pkg_nofetch() {
	einfo
	einfo "This package requires Qt4 libraries and frameworks"
	einfo "Please install kde-sunset overlay"
	einfo
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

src_prepare() {
	default
	sh autogen.sh --prefix=/usr --disable-hardening || die
}

src_install() {
	emake DESTDIR="${D}" install
}

pkg_postinst() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}
