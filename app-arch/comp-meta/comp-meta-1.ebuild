# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="compression algorithms metapackage"
HOMEPAGE="https://www.gnome.org/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="7z ace arj cpio deb iso +zip lha lzop +rar rpm unstuff zoo lz4 lz5"

DEPEND=""
RDEPEND="${DEPEND}
7z? ( app-arch/p7zip )
ace? ( app-arch/unace )
arj? ( app-arch/arj )
cpio? ( app-arch/cpio )
deb? ( app-arch/dpkg )
iso? ( app-cdr/cdrtools )
zip? ( app-arch/zip app-arch/unzip )
lha? ( app-arch/lha )
lzop? ( app-arch/lzop )
rar? ( app-arch/unrar )
rpm? ( app-arch/rpm )
unstuff? ( app-arch/stuffit )
zoo? ( app-arch/zoo )
lz4? ( app-arch/lz4 )
lz5? ( app-arch/lz5 )
"
