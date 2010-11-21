# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A graphical network connections viewer for Linux, similar in functionality with Netstat"
HOMEPAGE="netactview.sourceforge.net/"
SRC_URI="https://sourceforge.net/projects/netactview/files/netactview/netactview-${P}/netactview-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 "

DEPEND=">=x11-libs/gtk+-2.0 \
        >=gnome-base/libglade-2.0 \
        >=gnome-base/gnome-vfs-2.0 \
        >=dev-libs/glib-2.0 \
        >=gnome-base/libgnome-2.0 \
        >=gnome-base/gconf-2.0"

src_compile() {	
	econf $(use_with gtk) || die
	emake || die "make failed" 
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO* || die "dodoc falied" 
}

pkg_postinst() {
	elog "To report a problem goto:"
	elog " http://netactview.sourceforge.net/"
}

