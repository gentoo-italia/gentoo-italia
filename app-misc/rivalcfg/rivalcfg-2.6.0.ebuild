# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Unofficial tool for configuring SteelSeries Rival gaming mouse"
HOMEPAGE="https://github.com/flozz/rivalcfg"
SRC_URI="https://github.com/flozz/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="WTFPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/pyudev-0.19.0"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	sed -i -- 's|print("Installing udev rules...")|print("Installing udev rules...")\n        os.makedirs("'${D}'etc\/udev\/rules.d")|' setup.py
	sed -i -- 's|.rules", "\/etc\/udev\/rules.d|.rules", "'${D}'etc\/udev\/rules.d|' setup.py
	sed -i -- 's|subprocess.call(\["udevadm", "trigger"\])|pass|' setup.py
}
