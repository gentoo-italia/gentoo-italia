# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit apache-module eutils subversion

DESCRIPTION="Apache module for rewriting web pages to reduce latency and bandwidth"
HOMEPAGE="http://code.google.com/p/modpagespeed"

ESVN_REPO_URI="http://src.chromium.org/svn/trunk/tools/depot_tools"
EGCLIENT_REPO_URI="http://modpagespeed.googlecode.com/svn/trunk/src"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND=""

APACHE2_MOD_FILE="${S}/out/Release/${PN}.so"
APACHE2_MOD_CONF="80_${PN//-/_}"
APACHE2_MOD_DEFINE="PAGESPEED"

need_apache2_2

src_unpack() {
	subversion_src_unpack
	mv "${S}" "${WORKDIR}"/depot_tools

	EGCLIENT="${WORKDIR}"/depot_tools/gclient
	cd "${ESVN_STORE_DIR}" || die "gclient: can't chdir to ${ESVN_STORE_DIR}"

	if [[ ! -d ${PN} ]]; then
		mkdir -p "${PN}" || die "gclient: can't mkdir ${PN}."
	fi

	cd "${PN}" || die "gclient: can't chdir to ${PN}"

	if [[ ! -f .gclient ]]; then
		einfo "gclient config -->"
		${EGCLIENT} config ${EGCLIENT_REPO_URI} || die "gclient: error creating config"
	fi

	einfo "gclient sync start -->"
	einfo "     repository: ${EGCLIENT_REPO_URI}"
	${EGCLIENT} sync --force || die
	einfo "   working copy: ${ESVN_STORE_DIR}/${PN}"

	mkdir -p "${S}"
	rsync -rlpgo --exclude=".svn/" src/ "${S}" || die "gclient: can't export to ${S}."
}

src_compile() {
	emake BUILDTYPE=Release V=1 || die "emake failed"
}

src_install() {
	mv -f out/Release/libmod_pagespeed.so out/Release/${PN}.so
	apache-module_src_install

	keepdir /var/cache/mod_pagespeed /var/cache/mod_pagespeed/files
	fowners apache:apache /var/cache/mod_pagespeed /var/cache/mod_pagespeed/files
	fperms 0770 /var/cache/mod_pagespeed /var/cache/mod_pagespeed/files
}
