# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Decompresses deflate and other streams to make a file more compressable"
HOMEPAGE="http://schnaader.info/precomp.php"
EGIT_REPO_URI="git://github.com/schnaader/precomp-cpp.git https://github.com/schnaader/precomp-cpp.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	#Package doesn't have a make install option yet
	dobin precomp
}
