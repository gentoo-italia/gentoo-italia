# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit linux-info linux-mod

if [ "${PV}" = "9999" ]; then
	inherit git-2
	EGIT_REPO_URI="https://github.com/luigirizzo/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/luigirizzo/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="NETMAP is a framework for very fast packet I/O from userspace"
HOMEPAGE="https://github.com/luigirizzo/netmap"

LICENSE="BSD-2"
SLOT="0"
IUSE="no-drivers"

CONFIG_CHECK=""
MODULE_NAMES="netmap(misc:${S})"
BUILD_TARGETS=""

src_configure() {
    econf \
    	--no-drivers
}

src_compile(){
	#BUILD_PARAMS="KDIR=${KV_OUT_DIR} M=${S}"
	emake
}
