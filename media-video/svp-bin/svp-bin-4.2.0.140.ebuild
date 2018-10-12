# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN/-bin/}"

DESCRIPTION="SmoothVideo Project 4 (SVP4)"
HOMEPAGE="https://www.svp-team.com/wiki/SVP:Linux"
SRC_URI="https://gist.githubusercontent.com/phiresky/1e2cbd30bed4e5978771af232d11afd1/raw/svp4-${PV}.tbz2"

LICENSE="custom"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	media-libs/vapoursynth
	media-libs/libmediainfo
	dev-qt/qtsvg:5
	dev-qt/qtscript:5
	dev-qt/qtdeclarative:5
	dev-qt/qtconcurrent:5
	dev-libs/libusb
	x11-misc/xdg-utils
	sys-process/lsof
	app-arch/p7zip
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

pkg_nofetch() {
	einfo
	einfo "This package requires Vapoursynth."
	einfo "Please install vapoursynth overlay."
	einfo
}

src_prepare() {
	default
	rm -rf "${S}/installer"
	mkdir "${S}/installer"
	LANG=C grep --only-matching --byte-offset --binary --text  $'7z\xBC\xAF\x27\x1C' "${S}/svp4-linux-64.run" |
		cut -f1 -d: |
		while read ofs; do dd if="${S}/svp4-linux-64.run" bs=1M iflag=skip_bytes status=none skip=$ofs of="${S}/installer/bin-$ofs.7z"; done

	for f in "${S}/installer/"*.7z; do
		7z -bd -bb0 -y x -o"${S}/extracted/" "$f" || true
	done
}

src_install() {
	dodir {/opt/svp,/usr/share/licenses/svp}
	if [[ -d "${S}/extracted/licenses" ]]; then
		insinto /usr/share/licenses/svp
		doins -r "${S}/extracted/licenses"
	fi
	rm "${S}/extracted/extensions/libsvpcode.so"
	insinto /opt/svp
	doins -r "${S}"/extracted/*
	dosym /opt/svp/SVPManager /usr/bin/SVPManager
	fperms -R +rX /opt/svp
	fperms +x /opt/svp/SVPManager
	fperms +x /opt/svp/*.sh
	fperms -R +rX /usr/share
}

pkg_postinst() {
	elog "If you want to play a video file with mpv and svp, you must install mpv in vapoursynth overlay with vapoursynth use flag."
	elog "If you want hardware acceleration, your system must support opencl."
}
