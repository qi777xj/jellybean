# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )
inherit toolchain-funcs python-r1 meson ninja-utils gnome2-utils

DESCRIPTION="The maintainance fork of compton"
HOMEPAGE="https://github.com/yshui/compton"
SRC_URI="https://github.com/yshui/compton/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="dbus +drm opengl +pcre xinerama"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="${PYTHON_DEPS}
	dev-libs/libconfig:=
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libxcb
	x11-libs/xcb-util-renderutil
	x11-libs/xcb-util-image
	dev-libs/libev
	dbus? ( sys-apps/dbus )
	opengl? ( virtual/opengl )
	pcre? ( dev-libs/libpcre:3 )
	xinerama? ( x11-libs/libXinerama )"
RDEPEND="${COMMON_DEPEND}
	x11-apps/xprop
	x11-apps/xwininfo"
DEPEND="${COMMON_DEPEND}
	app-text/asciidoc
	virtual/pkgconfig
	x11-base/xorg-proto
	drm? ( x11-libs/libdrm )"

pkg_setup() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		tc-export CC
	fi
}

src_configure() {
	local emesonargs=(
		-Dopengl=$(usex opengl true false)
		-Dregex=$(usex pcre true false)
		-Ddbus=$(usex dbus true false)
		-Dvsync_drm=$(usex drm true false)
		-Dxinerama=$(usex xinerama true false)
		--buildtype=release
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile
	eninja -C ${WORKDIR}/${P}-build
}

src_install() {
	default
	DESTDIR=${D} eninja -C ${WORKDIR}/${P}-build install
	docinto examples
	dodoc compton.sample.conf dbus-examples/*
	python_foreach_impl python_newscript bin/compton-convgen.py compton-convgen
}

pkg_postinst() {
	gnome2_icon_cache_update
}
