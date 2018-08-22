# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils git-r3 multilib savedconfig toolchain-funcs

DESCRIPTION="simple terminal implementation for X"
HOMEPAGE="https://st.suckless.org/"
EGIT_REPO_URI="https://git.suckless.org/st"

LICENSE="MIT-with-advertising"
SLOT="0"
IUSE="savedconfig alpha dracula solarized-light solarized-dark solarized-both no_bold_colors xresources"

RDEPEND="
	>=sys-libs/ncurses-6.0:0=
	media-libs/fontconfig
	x11-libs/libX11
	x11-libs/libXft
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	x11-base/xorg-proto
"

REQUIRED_USE="
	dracula? ( !solarized-light !solarized-dark !solarized-both )
	solarized-light? ( !dracula !solarized-dark !solarized-both no_bold_colors )
	solarized-dark? ( !dracula !solarized-light !solarized-both no_bold_colors )
	solarized-both? ( !dracula !solarized-light !solarized-dark no_bold_colors )
"

src_prepare() {
	default

	epatch "${FILESDIR}"/st-vertcenter-20180320-6ac8c8a.patch
	epatch "${FILESDIR}"/st-scrollback-0.8.patch
	epatch "${FILESDIR}"/st-scrollback-mouse-0.8.patch

	if use alpha; then
		epatch "${FILESDIR}"/st-alpha-20180616-0.8.1.patch
	fi

	if use no_bold_colors; then
		epatch "${FILESDIR}"/st-no_bold_colors-0.8.1.patch
		use solarized-light && epatch "${FILESDIR}"/st-solarized-light-20170623-b331da5.patch
		use solarized-dark && epatch "${FILESDIR}"/st-solarized-dark-20180411-041912a.patch
		use solarized-both && epatch "${FILESDIR}"/st-solarized-both-0.8.1.patch
	fi

	if use dracula; then
		epatch "${FILESDIR}"/st-dracula-20170803-7f99032.patch
	fi

	if use xresources; then
		epatch "${FILESDIR}"/st-xresources-20180309-c5ba9c0.patch
	fi

	sed -i \
		-e "/^X11LIB/{s:/usr/X11R6/lib:/usr/$(get_libdir)/X11:}" \
		-e '/^STLDFLAGS/s|= .*|= $(LDFLAGS) $(LIBS)|g' \
		-e '/^X11INC/{s:/usr/X11R6/include:/usr/include/X11:}' \
		config.mk || die
	sed -i \
		-e '/tic/d' \
		Makefile || die

	restore_config config.h
}

src_configure() {
	sed -i \
		-e "s|pkg-config|$(tc-getPKG_CONFIG)|g" \
		config.mk || die

	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install

	dodoc TODO

	make_desktop_entry ${PN} simpleterm utilities-terminal 'System;TerminalEmulator;' ''

	save_config config.h
}

pkg_postinst() {
	if ! [[ "${REPLACING_VERSIONS}" ]]; then
		elog "Please ensure a usable font is installed, like"
		elog "    media-fonts/corefonts"
		elog "    media-fonts/dejavu"
		elog "    media-fonts/urw-fonts"
	fi
}
