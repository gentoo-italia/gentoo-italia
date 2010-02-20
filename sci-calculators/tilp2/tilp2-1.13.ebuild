# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"
inherit eutils

DESCRIPTION="Communication program for Texas Instruments calculators "
HOMEPAGE="http://lpg.ticalc.org/prj_tilp"
SRC_URI="http://www.ticalc.org/pub/unix/tilp.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls threads xinerama"

RDEPEND="sci-libs/libticalcs2
	sci-libs/libticables2
	sci-libs/libtifiles2
	sci-libs/libticonv
	!sci-calculators/tilp
	>=x11-libs/gtk+-2.6.0
	>=dev-libs/glib-2.6.0
	>=gnome-base/libglade-2
	nls? ( virtual/libintl )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	xinerama? ( x11-proto/xineramaproto )"

src_configure() {
	econf \
		--disable-rpath \
		$(use_enable threads) \
		$(use_enable threads threading) \
		--without-kde \
		$(use_with xinerama)
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	rm -f "${D}"usr/share/tiemu/{Manpage.txt,COPYING,RELEASE,AUTHORS,LICENSES}
	dodoc README AUTHORS ChangeLog RELEASE TODO
	make_desktop_entry tilp "TILP2 TI Linker" \
		/usr/share/tilp2/pixmaps/icon.xpm
}
