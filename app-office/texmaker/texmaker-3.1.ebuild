# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texmaker/texmaker-3.1.ebuild,v 1.1

EAPI="3"

inherit base qt4-r2 versionator

MAJOR="$(get_major_version)"
MINOR_1="$(($(get_version_component_range 2)/10))"
MINOR_2="$(($(get_version_component_range 2)%10))"

MY_P="${PN}-${MAJOR}.${MINOR_2}"


DESCRIPTION="A nice LaTeX-IDE"
HOMEPAGE="http://www.xm1math.net/texmaker/"
SRC_URI="http://www.xm1math.net/texmaker/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/${MY_P}"

COMMON_DEPEND="
	app-text/poppler[qt4]
	x11-libs/libX11
	x11-libs/libXext
	>=x11-libs/qt-gui-4.6.1:4
	>=x11-libs/qt-core-4.6.1:4
	>=x11-libs/qt-webkit-4.6.1:4
	>=app-text/hunspell-1.2.4"
RDEPEND="${COMMON_DEPEND}
	virtual/latex-base
	app-text/psutils
	app-text/ghostscript-gpl
	media-libs/netpbm"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

PATCHES=( "${FILESDIR}/${P}-hunspell.patch" )

src_install() {
	emake INSTALL_ROOT="${D}" install || die "make install failed"

	insinto /usr/share/pixmaps/texmaker
	doins utilities/texmaker*.png || die "doins failed."
	doins utilities/texmaker.svg || die "doins failed."

	dodoc utilities/AUTHORS utilities/CHANGELOG.txt || die "dodoc failed"
}

pkg_postinst() {
	elog "A user manual with many screenshots is available at:"
	elog "/usr/share/${PN}/usermanual_en.html"
}
