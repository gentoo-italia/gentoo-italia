# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sslstrip/sslstrip-0.7.ebuild,v 1.2 2009/12/21 13:20:56 ssuominen Exp $

EAPI=3
PYTHON_DEPEND="2"
#SUPPORT_PYTHON_ABIS="1"
#RESTRICT_PYTHON_ABIS="3.*"

inherit eutils

DESCRIPTION="This tool provides a demonstration of the HTTPS stripping attacks."
HOMEPAGE="http://thoughtcrime.org/software/sslstrip/"
SRC_URI="http://thoughtcrime.org/software/sslstrip/sslstrip-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/python
        dev-python/twisted-web"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}_custom.patch"
}

src_install() {
    python setup.py install
}
