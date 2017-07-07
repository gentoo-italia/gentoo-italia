# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

IUSE=""
LICENSE="CC-BY-SA-4.0"
SLOT="0"
DEPEND=""
RDEPEND="${DEPEND}"

DESCRIPTION="Paper icon theme"
HOMEPAGE="https://github.com/snwh/${PN}"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/snwh/${PN}.git"
	KEYWORDS="~amd64"
fi

src_prepare() {
	eapply_user
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
}
