# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Userspace tool to create ext4 encrypted directories."
HOMEPAGE="https://github.com/gdelugre/${PN}"

inherit cmake-utils 

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/gdelugre/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/gdelugre/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-3.0"
SLOT="0"

DEPEND="dev-libs/libsodium"
RDEPEND="${DEPEND}"
