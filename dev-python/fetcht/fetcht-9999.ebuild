# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Automatic torrent web crawler"
HOMEPAGE="https://github.com/hexvar/fetcht"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/hexvar/${PN}.git"
else
  SRC_URI="https://github.com/hexvar/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

python_test() {
	nosetests || die "tests failed under ${EPYTHON}"
}
