# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="2"

inherit eutils python distutils

DESCRIPTION="This tool provides a demonstration of the HTTPS stripping attacks."
HOMEPAGE="http://thoughtcrime.org/software/sslstrip/"
SRC_URI="http://thoughtcrime.org/software/sslstrip/sslstrip-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.5
         >=dev-python/twisted-web-8.1.0"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}_custom.patch"
}

src_install() {
    dodir /usr/lib/"${PN}"
	insinto /usr/lib/"${PN}"
    doins sslstrip.py lock.ico
    dodir /usr/lib/${PN}/sslstrip
    insinto /usr/lib/${PN}/sslstrip
    doins sslstrip/*.py
    dosbin "${FILESDIR}/sslstrip"
}

pkg_postinst() {
    python_mod_optimize
}

