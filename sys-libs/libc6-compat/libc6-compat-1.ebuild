# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit multilib

DESCRIPTION="Symlinks pointing apps linked against glibc2/libc6 to musl libraries"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

REQUIRED_USE="elibc_musl"

DEPEND=">=sys-libs/musl-1.1.0"

src_unpack() {
	mkdir ${S}
}

src_install() {
	dosym ld-musl-x86_64.so.1 /"$(get_libdir)"/ld-linux-x86-64.so.2
}
