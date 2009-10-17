# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
NEED_PYTHON=2.5

inherit distutils

DESCRIPTION="A simple and lightweight notify-osd GMail notifier."
HOMEPAGE="https://launchpad.net/gm-notify"
SRC_URI="http://launchpad.net/gm-notify/0.x/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${PN}_py2.5.patch"

	distutils_src_prepare
}
