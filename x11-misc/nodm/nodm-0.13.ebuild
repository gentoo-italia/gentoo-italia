# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit pam eutils systemd

DESCRIPTION="nodm is an automatic display manager which automatically starts an X session at system boot"
HOMEPAGE="http://www.enricozini.org/sw/nodm/"
#SRC_URI="http://www.enricozini.org/sw/${PN}/${P}.tar.gz"
SRC_URI="https://launchpad.net/debian/+archive/primary/+files/${PN}_${PV}.orig.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"

DEPEND="virtual/pam x11-base/xorg-server"

RDEPEND="${DEPEND}"

src_prepare() {
	./autogen.sh
	econf
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	newinitd "${FILESDIR}/nodm.initd" nodm || die
	newconfd "${FILESDIR}/nodm.confd" nodm || die
    
	if use systemd ; then
	    #install systemd service
    	systemd_dounit "${FILESDIR}/nodm.service" || die
	fi

	pamd_mimic system-local-login nodm auth account password session
}

pkg_postinst() {
	elog "If you're using fbsplash to display a splash screen during boot,"
	elog "then you need to have the following set in '/etc/conf.d/splash'."
	elog
	elog "SPLASH_XSERVICE=\"nodm\""
	elog
	elog "If you don't, you will most likely end up at tty1 at the end of"
	elog "the boot process (instead of in an X session)."
}
