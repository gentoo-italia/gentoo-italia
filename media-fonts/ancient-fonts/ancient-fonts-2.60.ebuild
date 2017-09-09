# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit font

MY_PN="Ancient Fonts"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Unicode Fonts for Ancient Scripts"
HOMEPAGE="http://users.teilar.gr/~g1951d/"
SRC_URI="mirror://debian/pool/main/t/ttf-ancient-fonts/ttf-ancient-fonts_${PV}.orig.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

FONT_SUFFIX="otf ttf"
FONT_S="${WORKDIR}/ttf-ancient-fonts-${PV}.orig"
S=${FONT_S}
