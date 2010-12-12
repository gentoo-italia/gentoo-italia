# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit flag-o-matic

DESCRIPTION="Canonical's on-screen-display notification agent."
HOMEPAGE="https://launchpad.net/notify-osd"
SRC_URI="http://launchpad.net/notify-osd/lucid/ubuntu-10.04-beta-2/+download/notify-osd-0.9.29.tar.gz"
#SRC_URI="http://launchpad.net/notify-osd/trunk/ubuntu-9.10/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/dbus-glib-0.76
	>=dev-libs/glib-2.16.0
	gnome-base/gconf:2
	>=x11-libs/gtk+-2.6
	x11-libs/libwnck"
RDEPEND=""

src_configure() { 
	epatch "${FILESDIR}"/*.patch
	append-flags -fno-strict-aliasing	# -Werror causes build to fail
	default
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
