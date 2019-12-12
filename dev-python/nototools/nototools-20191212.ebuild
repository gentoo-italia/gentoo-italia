# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_7 )

inherit distutils-r1

DESCRIPTION="Noto fonts support tools and scripts plus web site generation"
HOMEPAGE="https://github.com/googlei18n/nototools"

COMMIT="fc2eb7dc150f5e5bc4469a696faa50f62d1c0441"
SRC_URI="https://github.com/googlei18n/nototools/archive/${COMMIT}.tar.gz#/nototools-${COMMIT}.tar.gz"

LICENSE="Apache-2.0 OFL-1.1"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
BDEPEND=""
RDEPEND="${DEPEND}
	media-gfx/scour
	>=dev-python/booleanOperations-0.8.2[${PYTHON_USEDEP}]
	>=dev-python/defcon-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.0.2[${PYTHON_USEDEP}]
	>=dev-python/pillow-6.2.0[${PYTHON_USEDEP}]
	>=dev-python/pyclipper-1.1.0[${PYTHON_USEDEP}]
	virtual/python-typing[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${PN}-${COMMIT}"

python_test() {
	esetup.py test
}
