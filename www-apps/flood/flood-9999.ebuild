# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A modern web UI for rTorrent with a Node.js backend and React frontend."
HOMEPAGE="https://github.com/jfurrow/flood"

if [[ ${PV} == "9999" ]]; then
	SCM="git-r3"

	SRC_URI=""
	EGIT_REPO_URI="https://github.com/jfurrow/flood.git"
else
	SRC_URI="https://github.com/jfurrow/flood/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

inherit eutils ${SCM}

LICENSE="GPL-3.0"
SLOT="0"

DEPEND="
	net-p2p/rtorrent[xmlrpc]
	net-libs/nodejs[npm]
	media-video/mediainfo
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-${PV}

src_prepare() {
	default
	cp config.template.js config.js
	mkdir server/db
	chmod -R 750 server/db
	npm install || die "npm module installation failed"
}

src_compile() {
	npm run build || die "build failed"
}

src_install() {
	dodir /var/lib/flood
	insinto /var/lib/flood
	doins -r *
	fperms 755 /var/lib/flood
	insinto /etc/default
	newins config.template.js flood.js
	fperms 644 /etc/default/flood.js
	dodir /usr/share/flood
	dodir /usr/share/flood/.session
	dodir /usr/share/flood/torrent
	insinto /etc
	doins ${FILESDIR}/rtorrent.rc
	newinitd ${FILESDIR}/rtorrent.init rtorrentd
	newinitd ${FILESDIR}/flood.init flood
}

pkg_postinst() {
	elog
	elog "The rtorrent config file is /etc/rtorrent.rc"
	elog "The init scripts of flood and rtorrent(daemon) are flood and rtorrentd"
	elog
}
