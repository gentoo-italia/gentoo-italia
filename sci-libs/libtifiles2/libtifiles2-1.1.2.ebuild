# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libtifiles2/libtifiles2-1.1.1.ebuild,v 1.2 2009/03/24 23:08:52 josejx Exp $

EAPI=2

DESCRIPTION="Library for TI calculator files"
HOMEPAGE="http://lpg.ticalc.org/prj_tilp/"
SRC_URI="http://www.ticalc.org/pub/unix/tilibs.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc nls threads"

RDEPEND=">=dev-libs/glib-2.6.0
	sci-libs/libticables2
	sci-libs/libticonv
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack tilibs.tar.gz
        unpack tilibs2/${P}.tar.gz
}

src_configure() {
	econf \
		--disable-rpath \
		$(use_enable nls) \
		$(use_enable threads)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS LOGO NEWS README ChangeLog docs/api.txt
	if use doc; then
		dohtml docs/html/* || die
	fi
}
