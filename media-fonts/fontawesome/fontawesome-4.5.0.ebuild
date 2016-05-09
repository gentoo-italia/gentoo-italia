# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

MY_PN="Font-Awesome"
DESCRIPTION="The iconic font"
HOMEPAGE="http://fontawesome.io"

SRC_URI="https://github.com/FortAwesome/${MY_PN}/archive/v${PV}.zip -> ${P}.zip"
RESTRICT="mirror strip"

LICENSE="OFL-1.1 SIL CC-BY-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/${MY_PN}-${PV}
FONT_SUFFIX="ttf otf"
FONT_S=${S}/fonts
