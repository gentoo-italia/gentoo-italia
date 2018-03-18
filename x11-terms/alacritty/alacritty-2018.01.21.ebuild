# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils cargo git-r3

DESCRIPTION="GPU-accelerated terminal emulator"
HOMEPAGE="https://github.com/jwilm/alacritty"
SRC_URI=""
EGIT_REPO_URI="https://github.com/jwilm/alacritty"

if [[ $PV == 9999 ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64"
	EGIT_COMMIT_DATE="${PV}"
fi

RESTRICT="mirror"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

RDEPEND="
	media-libs/freetype:2=
	media-libs/fontconfig
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXxf86vm
	x11-libs/libXi
	media-libs/mesa
	x11-misc/xclip
"
DEPEND="${RDEPEND}
	dev-util/cmake
	virtual/pkgconfig
"

src_install() {
	cargo_src_install

	domenu Alacritty.desktop
	insinto /usr/share/alacritty
	doins alacritty.yml

	dodir /usr/share/terminfo/a
	tic -o "${ED}/usr/share/terminfo" alacritty.info
}

