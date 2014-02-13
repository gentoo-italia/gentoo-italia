# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3} )

inherit distutils-r1 eutils

DESCRIPTION="PySDL2 is a python wrapper around the SDL2 library"
HOMEPAGE="https://bitbucket.org/marcusva/py-sdl2"
SRC_URI="https://bitbucket.org/marcusva/py-sdl2/downloads/PySDL2-${PV}.zip"

LICENSE="CCO"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl2"
RDEPEND="${DEPEND}"

python_prepare_all() {
  distutils-r1_python_prepare_all
}

python_compile() {
  distutils-r1_python_compile
}

python_install_all() {
  distutils-r1_python_install_all
}

