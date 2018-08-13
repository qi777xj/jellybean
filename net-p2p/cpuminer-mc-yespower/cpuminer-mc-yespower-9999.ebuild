# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools flag-o-matic git-r3

DESCRIPTION="Cpuminer with yespower"
HOMEPAGE="https://github.com/cryptozeny/cpuminer-mc-yespower"
SRC_URI=""
EGIT_REPO_URI="https://github.com/cryptozeny/cpuminer-mc-yespower"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
REQUIRED_USE="cpu_flags_x86_sse2"
IUSE="cpu_flags_x86_sse2 libressl +curl"

RDEPEND="
	dev-lang/perl
	dev-libs/gmp:0
	dev-libs/jansson
	curl? ( >=net-misc/curl-7.15[ssl] )
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
"
DEPEND="
	${RDEPEND}
"

src_prepare(){
	eapply_user
	make clean
	sh autogen.sh
	perl nomacro.pl
}

src_configure(){
	econf
}

src_install(){
	emake DESTDIR="${D}" install
}
