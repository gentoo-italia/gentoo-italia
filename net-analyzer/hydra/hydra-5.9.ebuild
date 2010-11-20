# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hydra/hydra-5.8.ebuild,v 1.1 2010/10/15 16:05:45 jer Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Advanced parallized login hacker"
HOMEPAGE="http://www.thc.org/thc-hydra/"
SRC_URI="http://freeworld.thc.org/releases/${P}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk ssl"

DEPEND="
	dev-libs/openssl
	gtk? ( >=x11-libs/gtk+-1.2 )
	ssl? ( >=net-libs/libssh-0.4.0 )
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}-src

src_prepare() {
	# None of the settings in Makefile.unix are useful to us
	: > Makefile.unix

	sed -i \
		-e 's:-O2:$(CPPFLAGS) $(CFLAGS):g' \
		-e 's:|| echo.*$::' \
		-e '/\t-$(CC)/s/-//' \
		-e '/ -o /s:$(OPTS):& $(LDFLAGS):g' \
		Makefile.am || die "sed failed"
}

src_configure() {
	# Note: despite the naming convention, the top level script is not an
	# autoconf-based script.
	./configure \
		--prefix=/usr \
		$(use gtk && echo --disable-xhydra) \
			|| die "configure failed"

	sed -i \
		-e '/^XDEFINES=/s:=.*:=:' \
		-e '/^XLIBS=/s:=.*:=-lcrypto:' \
		-e '/^XLIBPATHS/s:=.*:=:' \
		-e '/^XIPATHS=/s:=.*:=:' \
		Makefile || die "pruning vars"

	if use ssl ; then
		sed -i \
			-e '/^XDEFINES=/s:=:=-DLIBOPENSSL -DLIBSSH:' \
			-e '/^XLIBS=/s:$: -lssl -lssh:' \
			Makefile || die "adding ssl"
	fi

	if use gtk ; then
		cd hydra-gtk && \
		econf || die "econf failed"
	fi
}

src_compile() {
	tc-export CC
	emake || die "make failed"
	if use gtk ; then
		cd hydra-gtk && \
		emake || die "emake hydra-gtk failed"
	fi
}

src_install() {
	dobin hydra pw-inspector || die "dobin failed"
	if use gtk ; then
		dobin hydra-gtk/src/xhydra || die "gtk"
	fi
	dodoc CHANGES README TODO
}
