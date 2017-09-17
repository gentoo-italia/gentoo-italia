# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Python wrapper wrapper for telegram you can't refuse"
HOMEPAGE="https://github.com/${PN}/${PN}"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz"

LICENSE="LGPL-V3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
dev-python/certifi[${PYTHON_USEDEP}]
>=dev-python/future-0.16.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
dev-python/setuptools[${PYTHON_USEDEP}]
"

python_prepare_all() {
	local PATCHES=(
		"${FILESDIR}"/${PN}-request.patch
	)
	rm -rf ${S}/telegram/vendor
	distutils-r1_python_prepare_all
}
