# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils git

EGIT_REPO_URI="git://github.com/Dieterbe/uzbl.git"
EGIT_BRANCH="experimental"

DESCRIPTION="Uzbl: A UZaBLe Keyboard-controlled Lightweight Webkit-based Web Browser"
HOMEPAGE="http://www.uzbl.org/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="extras"

RDEPEND=">=net-libs/webkit-gtk-1.1.4
	 >=x11-libs/gtk+-2.14
	extras? ( gnome-extra/zenity x11-misc/dmenu )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	git_src_unpack
	cd "${S}"

	sed -i 's:\(PREFIX?=$(DESTDIR)/usr\)/local:\1:' Makefile || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README
	doicon examples/data/uzbl/uzbl.png
}

pkg_postinst() {
	einfo "You need to make a configuration files in $HOME/.config/uzbl."
	einfo "An example config is in /usr/share/doc/${PN}/examples/config/${PN}."
}
