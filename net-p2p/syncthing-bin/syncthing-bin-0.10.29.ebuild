# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit pax-utils user

DESCRIPTION="Open Source Continuous File Synchronization"
HOMEPAGE="https://syncthing.net/"
SRC_URI="amd64? ( https://github.com/syncthing/syncthing/releases/download/v${PV}/syncthing-linux-amd64-v${PV}.tar.gz )
	x86? ( https://github.com/syncthing/syncthing/releases/download/v${PV}/syncthing-linux-386-v${PV}.tar.gz  )"

LICENSE="MPLv2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
    insinto /usr/lib/systemd/system

	MY_ARCH=${ARCH}
	# i386 -> 386
	[ ${ARCH:0:1} == "i" ] && MY_ARCH=${ARCH:1}

	doins "${S}/syncthing-linux-${MY_ARCH}-v${PV}/etc/linux-systemd/system/syncthing@.service"

	mkdir -p "${D}/usr/bin"
	cp "syncthing-linux-${MY_ARCH}-v${PV}/syncthing" "${D}/usr/bin/syncthing"
	pax-mark m "${D}/usr/bin/syncthing"
}
