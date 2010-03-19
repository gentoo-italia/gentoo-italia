# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hamachi/hamachi-0.9.9.9_p20-r4.ebuild,v 1.3 2009/09/08 17:11:21 ikelos Exp $

inherit eutils linux-info

# gHamachi GUI

MY_PV=${PV/_p/-}
MY_P=${PN}-${MY_PV}-lnx

DESCRIPTION="Hamachi is a secure mediated peer to peer."
HOMEPAGE="http://hamachi.cc"
LICENSE="as-is"
SRC_URI="sse? ( http://files.hamachi.cc/linux/${MY_P}.tar.gz )
	!sse? ( http://files.hamachi.cc/linux/${MY_P}-pentium.tar.gz )"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="sse"
RESTRICT="strip mirror"

# Set workdir for both hamachi versions
if use sse; then
	S=${WORKDIR}/${MY_P}
else
	S=${WORKDIR}/${MY_P}-pentium
fi

pkg_preinst() {
	# Add group "hamachi" & user "hamachi"
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
	epatch "${FILESDIR}"/tuncfg.patch
}

pkg_setup() {
	einfo "Checking your kernel configuration for TUN/TAP support."
	CONFIG_CHECK="~TUN"
	check_extra_config
}

src_compile() {
	# Compile Tuncfg
	make -sC "${S}"/tuncfg || die "Compiling of tunecfg failed"
}

src_install() {
	# Hamachi
	einfo "Installing Hamachi"
	insinto /usr/bin
	insopts -m0755
	doins hamachi
	dosym /usr/bin/hamachi /usr/bin/hamachi-init

	# Tuncfg
	einfo "Installing Tuncfg"
	insinto /usr/sbin
	insopts -m0700
	doins tuncfg/tuncfg

	# Create log directory
	dodir /var/log/${PN}

	# Config files
	einfo "Installing config files"
	newinitd "${FILESDIR}"/tuncfg.initd tuncfg
	newconfd "${FILESDIR}"/hamachi.confd hamachi
	newinitd "${FILESDIR}"/hamachi.initd.2 hamachi

	# Docs
	dodoc CHANGES README LICENSE LICENSE.openssh LICENSE.openssl LICENSE.tuncfg

}

pkg_postinst() {
	einfo "To start Hamachi just type:"
	einfo "/etc/init.d/hamachi start"

	# added for bug #218481
	einfo "If the 'hamachi' command shows no output, use the following command"
	einfo "to extract the hamachi executable either with app-arch/upx or"
	einfo "app-arch/upx-ucl:"
	einfo "/opt/bin/upx -d /usr/bin/hamachi"
}
