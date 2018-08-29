# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CHROMIUM_PV="${PV/_pre2/}-2"

CHROMIUM_LANGS="
	am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fi fil fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv sw ta te th tr uk vi zh-CN zh-TW
"

inherit chromium-2 gnome2-utils xdg-utils eutils

DESCRIPTION="Modifications to Google Chromium for removing Google integration and enhancing privacy, control, and transparency"
HOMEPAGE="https://github.com/Eloston/ungoogled-chromium"
SRC_URI="https://github.com/Eloston/ungoogled-chromium-binaries/releases/download/${CHROMIUM_PV}/ungoogled-chromium_${CHROMIUM_PV}_linux.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome-keyring flash kde suid"

DEPEND="
	x11-libs/gtk+:3
	dev-libs/nss
	media-libs/alsa-lib
	x11-misc/xdg-utils
	x11-libs/libXScrnSaver
	net-print/cups
	dev-libs/libgcrypt
	sys-apps/dbus
	media-sound/pulseaudio
	sys-apps/pciutils
	dev-libs/json-glib
	dev-util/desktop-file-utils
	x11-themes/hicolor-icon-theme
	gnome-keyring? ( gnome-base/gnome-keyring )
	flash? ( www-plugins/adobe-flash )
	kde? (
		kde-apps/kdialog
		kde-frameworks/kwallet
	)
	!www-client/chromium
"
RDEPEND="${DEPEND}"

QA_PREBUILT="*"

S="${WORKDIR}/ungoogled-chromium_${CHROMIUM_PV/-2/}-1_linux"

pkg_setup() {
	chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default

	pushd "${S}/locales" > /dev/null || die
		chromium_remove_language_paks
	popd > /dev/null || die
}

src_install() {
	local CHROMIUM_HOME="/usr/$(get_libdir)/chromium-browser"
	exeinto "${CHROMIUM_HOME}"
	doexe chrome
	if use suid; then
		newexe chrome_sandbox chrome-sandbox
	fi
	local sedargs=( -e "s:/usr/lib/:/usr/$(get_libdir)/:g" )
	sed "${sedargs[@]}" "${FILESDIR}/chromium-launcher-r3.sh" > chromium-launcher.sh || die
	doexe chromium-launcher.sh
	dosym "${CHROMIUM_HOME}/chromium-launcher.sh" /usr/bin/chromium-browser
	dosym "${CHROMIUM_HOME}/chromium-launcher.sh" /usr/bin/chromium

	insinto "${CHROMIUM_HOME}"
	doins *.bin
	doins *.pak
	doins *.so
	doins icudtl.dat
	doins -r locales
	doins -r resources

	insinto /usr/share/applications
	doins "${FILESDIR}"/chromium-browser.desktop

	insinto /usr/share/gnome-control-center/defaults-apps
	newins "${FILESDIR}"/chromium-browser.xml chromium-browser.xml

	insinto /usr/share/icons/hicolor/48x48/apps
	newins product_logo_48.png chromium.png
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}
