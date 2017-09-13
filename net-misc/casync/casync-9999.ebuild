# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson

DESCRIPTION="Content-Addressable Data Synchronization Tool"
HOMEPAGE="https://github.com/systemd/casync"

if [ $PV -eq "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/systemd/casync"
	EGIT_CLONE_TYPE="shallow"
else
	SRC_URI="https://github.com/systemd/${PN}/archive/v${PV}.tar.gz"
fi

LICENSE="LGPL2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+fuse selinux"

RDEPEND="
	sys-libs/zlib
	>=net-misc/curl-7.32.0
	>=dev-libs/openssl-1.0
	>=app-arch/xz-utils-5.1.0
	app-arch/zstd
	sys-apps/acl
	fuse? ( >=sys-fs/fuse-2.6 )
	selinux? ( sys-libs/libselinux )
"

DEPEND="
	${RDEPEND}
	dev-python/sphinx
"

src_configure() {
        local emesonargs=(
                -Dfuse=$(usex fuse true false)
                -Dselinux=$(usex selinux true false)
        )
        meson_src_configure
}
