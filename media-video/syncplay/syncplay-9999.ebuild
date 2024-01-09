# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_7 )

inherit git-r3 python-r1

MY_PV=${PV/_rc/-RC}

DESCRIPTION="Client/server to synchronize media playback"
HOMEPAGE="https://syncplay.pl"
EGIT_REPO_URI="https://github.com/Syncplay/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="+client +server vlc"
REQUIRED_USE="vlc? ( client )
	${PYTHON_REQUIRED_USE}"

DEPEND=""
RDEPEND="${PYTHON_DEPS}
	>=dev-python/twisted-16.0.0[${PYTHON_USEDEP}]
	vlc? ( media-video/vlc[lua] )"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	default
}

src_compile() {
	:
}

src_install() {
	local MY_MAKEOPTS=( DESTDIR="${D}" PREFIX=/usr )
	use client && \
		emake "${MY_MAKEOPTS[@]}" VLC_SUPPORT=$(usex vlc true false) install-client
	use server && \
		emake "${MY_MAKEOPTS[@]}" install-server
}

pkg_postinst() {
	if use client; then
		einfo "Syncplay supports the following players:"
		einfo "media-video/mpv, media-video/mplayer2, media-video/vlc"
	fi
}
