# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Evopop gtk theme"
HOMEPAGE="https://github.com/solus-project/${PN}"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3 autotools
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/solus-project/${PN}.git"
	KEYWORDS=""
else
	inherit autotools
	SRC_URI="https://github.com/solus-project/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-3.0"
SLOT="0"

RDEPEND="
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
}
