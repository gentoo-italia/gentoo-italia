# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

PYTHON_COMPAT=( python2_7 )
inherit autotools autotools-utils bash-completion-r1 eutils python-any-r1

DESCRIPTION="Archlinux's binary package manager"
HOMEPAGE="http://archlinux.org/pacman/"
SRC_URI="https://git.archlinux.org/pacman.git/snapshot/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="curl debug doc gpg test"

COMMON_DEPEND="app-arch/libarchive
	dev-libs/openssl
	virtual/libiconv
	virtual/libintl
	sys-devel/gettext
	curl? ( net-misc/curl )
	gpg? ( app-crypt/gpgme )"
RDEPEND="${COMMON_DEPEND}
	app-arch/xz-utils"
# autoconf macros from gpgme requied unconditionally
# makepkg collision with old bash-completion
DEPEND="${COMMON_DEPEND}
	app-crypt/gpgme
	doc? ( app-doc/doxygen
		app-text/asciidoc )
	test? ( ${PYTHON_DEPS} )
	!<=app-shells/bash-completion-2.1-r90"

RESTRICT="test"

src_prepare() {
	# Remove a line that adds -Werror in ./configure when --enable-debug
	# is passed:
	sed -i -e '/-Werror/d' configure.ac || die "-Werror"

	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--localstatedir=/var
		--disable-git-version
		--with-openssl
		# Help protect user from shooting his/her Gentoo installation in
		# its foot.
		--with-root-dir="${EPREFIX}"/var/chroot/archlinux
		$(use_enable debug)
		$(use_enable doc)
		$(use_enable doc doxygen)
		$(use_with curl libcurl)
		$(use_with gpg gpgme)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	dodir /etc/pacman.d
	bashcomp_alias pacman pacman-key makepkg
}

pkg_postinst() {
	einfo "Please see http://ohnopub.net/~ohnobinki/gentoo/arch/ for information"
	einfo "about setting up an archlinux chroot."
}
