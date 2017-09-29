# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
ETYPE="sources"

inherit kernel-2
detect_version
detect_arch

DESCRIPTION="Kernel Linux ${KV_MAJOR}.${KV_MINOR} + grsecurity patch by alpine linux"
HOMEPAGE="https://github.com/alpinelinux/aports/tree/master/main/linux-hardened"
IUSE=""
RDEPEND=">=sys-devel/gcc-4.5"

SRC_URI="${KERNEL_URI} https://dev.alpinelinux.org/~ncopa/grsec/hardened-3.1-${PV}-201704252333-alpine.patch"

KEYWORDS="~amd64 ~x86"

src_prepare() {
	default
	eapply "${DISTDIR}"/*-alpine.patch
}
pkg_postinst()
{
	kernel-2_pkg_postinst
	einfo "This is not an official ebuild, do not report problems in Gentoo Bugzilla."
	einfo "Report any problems on the GitHub repository https://github.com/hexec/gentoo-italia/issues"
	
}
