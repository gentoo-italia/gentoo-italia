# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

SRC_URI="https://github.com/Dman95/SASM/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/SASM-${PV}"


DESCRIPTION="Simple crossplatform IDE for NASM assembly language"
HOMEPAGE="http://dman95.github.io/SASM/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
REPEND="${DEPEND}
	sys-devel/gcc
	sys-devel/gdb
"

src_configure() {
	eqmake5
}

src_install() {
	emake install INSTALL_ROOT="${D}"
}
pkg_postinst() {

		ewarn "For correct working  must be installed  nasm or gas (if you will use they, fasm already included in SASM)"

}

