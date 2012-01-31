# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

PYTHON_DEPEND="*:2.4"
inherit python

DESCRIPTION="A flexible python based build system with build phases and object cache."
HOMEPAGE="http://code.google.com/p/waf/"
SRC_URI="http://waf.googlecode.com/files/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 x86 ~amd64 amd64"
IUSE=""
DEPEND=">=dev-lang/python-2.4"
RDEPEND="${DEPEND}"

PREFIX=${D}/usr

src_compile() {
	./waf-light configure --prefix=${PREFIX} --nopyc --nopyo --nostrip ${MAKEOPTS}
	./waf-light --make-waf

	# make waf put the cache into /tmp/
	epatch "${FILESDIR}"/${PV}-cache-in-tmp.patch
}

src_install() {
        # just put waf into /usr/bin - it dynamically creates the additional files it needs in /tmp/
        dobin waf
        dodoc README ChangeLog
}

pkg_postrm() {
	# remove the cache files
        rm -r /tmp/.waf-${PV}*
	rm -r /tmp/.waf3-${PV}*

}
