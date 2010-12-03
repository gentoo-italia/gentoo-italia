# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-web/twisted-web-10.1.0.ebuild,v 1.3 2010/10/25 02:56:59 jer Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
MY_PACKAGE="Web"

inherit eutils twisted versionator

DESCRIPTION="Twisted web server, programmable in Python"

KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="soap"

DEPEND="=dev-python/twisted-$(get_version_component_range 1-2)*
	soap? ( dev-python/soappy )"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="twisted/plugins twisted/web"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-0.5.0-root-skip.patch"
}
