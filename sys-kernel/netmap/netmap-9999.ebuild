# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

if [ "${PV}" = "9999" ]; then
  inherit git-r3
  EGIT_REPO_URI="https://github.com/luigirizzo/${PN}.git"
else
  inherit vcs-snapshot
  SRC_URI="https://github.com/luigirizzo/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

KEYWORDS="~amd64"
DESCRIPTION="NETMAP is a framework for very fast packet I/O from userspace"
HOMEPAGE="https://github.com/luigirizzo/netmap"

LICENSE="BSD-2"
SLOT="0"
IUSE="no-drivers"

DEPEND="sys-libs/glibc"

src_configure() {
    ./configure --kernel-sources=/usr/src/linux --drivers="veth.c" \
                --driver-suffix="_netmap" --install-mod-path="${D}" --prefix="${D}/usr/local" --destdir="${D}"
}

src_compile(){
    emake
}
