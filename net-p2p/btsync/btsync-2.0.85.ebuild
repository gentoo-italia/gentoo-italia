# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit pax-utils user

DESCRIPTION="Sync stuff via BitTorrent"
HOMEPAGE="http://labs.bittorrent.com/experiments/sync.html"
SRC_URI="amd64? ( https://download-cdn.getsyncapp.com/${PV}/linux-x64/BitTorrent-Sync_x64.tar.gz )
	x86? ( https://download-cdn.getsyncapp.com/${PV}/linux-i386/BitTorrent-Sync_i386.tar.gz )
	ppc? ( https://download-cdn.getsyncapp.com/${PV}/linux-powerpc/BitTorrent-Sync_powerpc.tar.gz )
	arm? ( https://download-cdn.getsyncapp.com/${PV}/linux-arm/BitTorrent-Sync_arm.tar.gz )"

LICENSE="BitTorrent"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~ppc"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

QA_PREBUILT="usr/bin/btsync"

pkg_setup() {
    enewgroup btsync
    enewuser  btsync -1 -1 -1 "btsync"
}

src_install() {
	dodoc LICENSE.TXT

	insinto /etc
	doins "${FILESDIR}/btsync.conf"

    insinto /usr/lib/systemd/system
    doins "${FILESDIR}/btsync@.service"

	mkdir -p "${D}/usr/bin"
	cp btsync "${D}/usr/bin/btsync"
	pax-mark m "${D}/usr/bin/btsync"
}
