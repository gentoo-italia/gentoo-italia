# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libticalcs2/libticalcs2-1.1.3.ebuild,v 1.2 2009/03/24 23:10:06 josejx Exp $

EAPI=2
inherit eutils

DESCRIPTION="Library for communication with TI calculators"
HOMEPAGE="http://lpg.ticalc.org/prj_tilp/"
SRC_URI="http://repo.calcforge.org/debian/source/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc nls threads"

RDEPEND=">=dev-libs/glib-2.6.0
	>=sci-libs/libticables2-1.2.0
	>=sci-libs/libticonv-1.1.0
	>=sci-libs/libtifiles2-1.1.0
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.1.0-locale.patch
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
		dohtml docs/html/*
	fi
}
