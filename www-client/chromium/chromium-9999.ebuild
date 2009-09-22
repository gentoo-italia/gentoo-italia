# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

EGCLIENT_REPO_URI="http://src.chromium.org/svn/trunk/src/"
EGCLIENT_CONFIG="${FILESDIR}/.gclient"

inherit gclient eutils flag-o-matic 

RESTRICT="mirror"

DESCRIPTION="Chromium is the open-source project behind Google Chrome."
HOMEPAGE="http://code.google.com:80/chromium/"

LICENSE="GPL-2"
SLOT="live"

IUSE=""

DEPEND="
	>=dev-lang/python-2.4
	>=dev-lang/perl-5.0
	>=sys-devel/gcc-4.2
	>=sys-devel/bison-2.3
	>=sys-devel/flex-2.5.34
	>=dev-util/gperf-3.0.3
	>=dev-util/pkgconfig-0.20
	>=dev-libs/nss-3.12
	dev-libs/glib:2
	x11-libs/gtk+:2
	>=dev-libs/nspr-4.7.1
	media-fonts/corefonts
	>=dev-util/scons-1.2.0 
	>=sys-apps/sandbox-1.8
"
RDEPEND="${DEPEND}"

S="${S}/src"

pkg_setup() {

	use amd64 && die "No 64bit support at this time!"

}

src_prepare() {

	cd ${S}/src/chrome/browser

	filter-ldflags -Wl,--as-needed 

	export HOME=${S}
	mkdir ~/.gyp
	echo "{"					> ~/.gyp/include.gypi
	echo " 'variables': {" 				>> ~/.gyp/include.gypi
	echo "  'branding': 'Chromium-Gentoo'," 	>> ~/.gyp/include.gypi
	#echo "  'library': 'shared_library'," 		>> ~/.gyp/include.gypi
	echo " }," 					>> ~/.gyp/include.gypi
	echo " 'target_defaults': {" 			>> ~/.gyp/include.gypi
	echo "  'cflags': [ '${CFLAGS// /','}' ],"      >> ~/.gyp/include.gypi 
	echo "  'ldflags': [ '${LDFLAGS// /','}' ],"    >> ~/.gyp/include.gypi
	echo " }," 					>> ~/.gyp/include.gypi
	echo "}" 					>> ~/.gyp/include.gypi

	cd ${S}
		src/tools/gyp/gyp_chromium src/build/all.gyp || die "gpy failed"

}

src_compile() {

	cd ${S}/src/chrome
	scons --mode=Release --site-dir=../site_scons ${MAKEOPTS} chrome || die "scons build failed"

}

src_install() {

	cd ${S}/src/sconsbuild/Release

	dodir /opt/${PN}
	dodir /opt/${PN}/locales
	dodir /opt/${PN}/themes

	insinto /opt/${PN}
	doins chrome.pak

	insinto /opt/${PN}/locales
	doins -r locales/*

	insinto /opt/${PN}/themes
	doins -r themes/*

	exeinto /opt/${PN}
	doexe chrome || die "no chrome bin?"
	dosym /opt/${PN}/chrome /opt/bin/chrome	

	newicon "${S}/src/chrome/app/theme/chromium/product_logo_256.png" 
	make_desktop_entry "/opt/bin/chrome" "chromium-browser.png" "Network;WebBrowser;"

}
