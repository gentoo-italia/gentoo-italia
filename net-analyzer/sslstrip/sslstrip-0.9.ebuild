# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2:2.5"

inherit eutils python distutils

DESCRIPTION="sslstrip provides a demonstration of a HTTPS stripping attack"
HOMEPAGE="http://www.thoughtcrime.org/software/sslstrip/"
SRC_URI="http://www.thoughtcrime.org/software/sslstrip/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/twisted-web"

src_prepare() {
	epatch "${FILESDIR}/sslstrip_custom.patch"
}
