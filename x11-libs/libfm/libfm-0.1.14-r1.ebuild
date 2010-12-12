# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libfm/libfm-0.1.14.ebuild,v 1.2 2010/10/17 12:00:33 hwoarang Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="Library for file management"
HOMEPAGE="http://pcmanfm.sourceforge.net/"
SRC_URI="mirror://sourceforge/pcmanfm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug demo gnome hal udev"

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	udev? ( sys-fs/udisks )
	gnome? ( hal? ( gnome-base/gnome-mount ) )
	gnome? ( gnome-base/gvfs[hal?,udev?] )
	>=lxde-base/menu-cache-0.3.2"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	dev-util/gtk-doc
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	for file in app-chooser.ui ask-rename.ui file-prop.ui preferred-apps.ui \
		progress.ui;do
			echo "data/ui/${file}" >> po/POTFILES.in
	done
	echo "src/udisks/g-udisks-device.c" >> po/POTFILES.in
	gtkdocize
	eautoreconf
	einfo "Running intltoolize ..."
	intltoolize --force --copy --automake || die
	strip-linguas -i "${S}/po"
}

src_configure() {
    epatch "${FILESDIR}/disable_deprecated_gio_module.patch"
    epatch "${FILESDIR}/libfm-0.1.14-API-changes.patch"
    epatch "${FILESDIR}/lxde-conf.patch"
    epatch "${FILESDIR}/add_gobject_link.patch"

	econf --sysconfdir=/etc \
		$(use_enable debug) \
		$(use_enable demo) \
		$(use_enable udev udisks)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS TODO || die
}
