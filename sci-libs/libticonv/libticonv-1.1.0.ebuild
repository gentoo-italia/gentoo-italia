# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libticonv/libticonv-1.1.0.ebuild,v 1.2 2009/03/24 23:08:11 josejx Exp $

EAPI=2

DESCRIPTION="Charset conversion library for TI calculators"
HOMEPAGE="http://lpg.ticalc.org/prj_tilp/"
SRC_URI="mirror://sourceforge/gtktiemu/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc iconv nls"

RDEPEND=">=dev-libs/glib-2.6.0
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_configure() {
	econf \
		--disable-rpath \
		$(use_enable nls) \
		$(use_enable iconv)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS LOGO NEWS README ChangeLog docs/api.txt
	if use doc; then
		dohtml docs/html/*
		docinto charsets
		dohtml docs/charsets/*
	fi
}
