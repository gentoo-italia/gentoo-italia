# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="A simple, flat and bold Gtk theme for Solus OS & Budgie Desktop. Iris Dark was used as base."
HOMEPAGE="https://github.com/solus-cold-storage/${PN}"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3 autotools
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/solus-cold-storage/${PN}.git"
else
	inherit autotools
	SRC_URI="https://github.com/solus-cold-storage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="GPL-3.0"
SLOT="0"

RDEPEND="
	>=x11-libs/gtk+-3.16
"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
}
