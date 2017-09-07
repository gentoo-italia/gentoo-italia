# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit pam autotools

DESCRIPTION="PAM Module for two step verification via mobile platform"
HOMEPAGE="https://github.com/google/google-authenticator"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/google/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/google/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/pam"
RDEPEND="${DEPEND}"

RESTRICT="test"
# Test fails with:
# pam_google_authenticator_unittest: pam_google_authenticator_unittest.c:317: main: Assertion `pam_sm_open_session(((void *)0), 0, targc, targv) == 0' failed.
# No user name available when checking verification code

S=${WORKDIR}/${P}/libpam

src_prepare(){
	eautoreconf
}

pkg_postinst(){
	elog "For further information see"
	elog "http://wiki.gentoo.org/wiki/Google_Authenticator"
	elog ""
	elog "If you want support for QR-Codes, install media-gfx/qrencode."
}
