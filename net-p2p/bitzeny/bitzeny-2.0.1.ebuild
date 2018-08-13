# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
DB_VER="4.8"
inherit autotools bash-completion-r1 db-use gnome2-utils xdg-utils

MY_P="bitzeny-z2.0.1"

DESCRIPTION="BitZeny core"
HOMEPAGE="https://bitzeny.tech/"
SRC_URI="https://github.com/BitzenyCoreDevelopers/bitzeny/archive/z2.0.1.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+asm +bip70 +dbus kde +libevent libressl +qrcode +upnp +wallet +zeromq +qt5"

RDEPEND="
	>=dev-libs/boost-1.52.0:=[threads(+)]
	>=dev-libs/libsecp256k1-0.0.0_pre20151118:=[recovery]
	dev-libs/univalue:=
	qt5? ( dev-qt/qtcore:5= )
	qt5? ( dev-qt/qtgui:5= )
	qt5? ( dev-qt/qtnetwork:5= )
	qt5? ( dev-qt/qtwidgets:5= )
	virtual/bitcoin-leveldb
	bip70? ( dev-libs/protobuf:= )
	dbus? (
		dev-qt/qtdbus:5
	)
	libevent? ( dev-libs/libevent:= )
	!libressl? ( dev-libs/openssl:0=[-bindist] )
	libressl? ( dev-libs/libressl:0= )
	qrcode? (
		media-gfx/qrencode:=
	)
	upnp? ( >=net-libs/miniupnpc-1.9.20150916:= )
	wallet? ( sys-libs/db:$(db_ver_to_slot "${DB_VER}")=[cxx] )
	zeromq? ( net-libs/zeromq:= )
	!net-p2p/BitZenyPlus
"
DEPEND="
	${RDEPEND}
	dev-qt/linguist-tools:5
"

S=${WORKDIR}/${MY_P}

src_prepare(){
	eapply_user
	sh autogen.sh || die
}

src_configure(){
	econf
}

src_install(){
	emake DESTDIR="${D}" install
}
