# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
ETYPE="sources"

inherit kernel-2
detect_version
detect_arch

DESCRIPTION="kernel linux ${KV_MAJOR}.${KV_MINOR} + grsecurity patch by alpine linux"
HOMEPAGE="https://github.com/alpinelinux/aports/tree/master/main/linux-hardened"
IUSE=""
RDEPEND=">=sys-devel/gcc-4.5"

SRC_URI="${KERNEL_URI} https://raw.githubusercontent.com/alpinelinux/aports/master/main/linux-hardened/test.patch"

KEYWORDS="~amd64 ~x86"

src_prepare() {
	default
	eapply "${DISTDIR}"/test.patch
}
