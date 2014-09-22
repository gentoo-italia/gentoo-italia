# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PLOCALES="cs de en es fr he it ja lv nl pt pt_BR ru zh"

inherit multilib l10n qt4-r2

DESCRIPTION="A general purpose tile map editor"
HOMEPAGE="http://www.mapeditor.org/"
SRC_URI="https://github.com/bjorn/tiled/archive/v${PV}/${PN}-${PV}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

DEPEND=">=dev-qt/qtcore-4.6:4
	>=dev-qt/qtgui-4.6:4
	>=dev-qt/qtopengl-4.6:4
	sys-libs/zlib"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}/${PN}-${PV}

DOCS=( AUTHORS COPYING NEWS README.md )

src_configure() {
	qmake LIBDIR="/usr/$(get_libdir)" PREFIX="/usr"
	make
}

src_install() {
	qt4-r2_src_install

	if use examples ; then
		docompress -x /usr/share/doc/${PF}/examples
		dodoc -r examples
	fi
}
