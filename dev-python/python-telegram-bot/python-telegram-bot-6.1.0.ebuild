# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Python wrapper wrapper for telegram you can't refuse"
HOMEPAGE="https://github.com/python-telegram-bot/python-telegram-bot"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz"

LICENSE="LGPL-V3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
    dev-python/setuptools[${PYTHON_USEDEP}]"

