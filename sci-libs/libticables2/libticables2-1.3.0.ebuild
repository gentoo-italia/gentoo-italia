# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2
inherit eutils

DESCRIPTION="Library to handle different link cables for TI calculators"
HOMEPAGE="http://lpg.ticalc.org/prj_tilp/"
SRC_URI="http://www.ticalc.org/pub/unix/tilibs.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc nls threads usb"

RDEPEND=">=dev-libs/glib-2
	usb? ( dev-libs/libusb )
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack tilibs.tar.gz
        unpack  /var/tmp/portage/sci-libs/${P}/work/tilibs2/${P}.tar.gz
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-locale.patch
}

src_configure() {
	econf \
		--disable-rpath \
		$(use_enable nls) \
		$(use_enable usb libusb) \
		$(use_enable threads)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS LOGO NEWS README ChangeLog docs/api.txt
	if use doc; then
		dohtml docs/html/*
	fi
}

pkg_postinst() {
	elog "Please read README in /usr/share/doc/${PF}"
	elog "if you encounter any problem with a link cable"
}
