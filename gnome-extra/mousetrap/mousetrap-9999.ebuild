# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
inherit git eutils
EGIT_REPO_URI="http://git.gnome.org./cgit/mousetrap/"
EGIT_PROJECT="mousetrap"
SRC_URI=""

DESCRIPTION="A cam mouse intercace"
HOMEPAGE="http://git.gnome.org./cgit/mousetrap/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~mips ~sparc ~x86 ~amd64"

RDEPEND=">=media-libs/opencv-1.0.0-r1 
		>=dev-python/python-xlib-0.14"
DEPEND="${RDEPEND}"
PDEPEND=""

src_unpack() {
	git_src_unpack
	cd "${S}"
	./autogen.sh
}

src_compile() {
   econf || die
   emake || die "make failed" 
}

src_install() {
	emake install DESTDIR="${D}" || die
}
