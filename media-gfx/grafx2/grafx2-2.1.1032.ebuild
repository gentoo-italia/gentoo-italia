# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A pixelart-oriented painting program"
HOMEPAGE="http://code.google.com/p/grafx2/"
SRC_URI="http://grafx2.googlecode.com/files/${P}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="ttf"

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/freetype
	ttf? ( media-libs/sdl-ttf )"
RDEPEND=""

src_compile() {
	use ttf || MYCNF="NOTTF=1"
	cd ${WORKDIR}/${PN}
	emake ${MYCNF} || die "emake failed"
}

src_install() {
	cd ${WORKDIR}/${PN}
	emake DESTDIR="${D}" PREFIX="/usr" install || die "Install failed"
}

pkg_postinst() {
	elog "To report a problem goto:"
	elog " http://code.google.com/p/grafx2"
}

