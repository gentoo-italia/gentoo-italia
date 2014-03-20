# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils versionator

RESTRICT="strip"
QA_TEXTRELS="opt/${P}/bin/libbreakgen.so"
STUDIO_V=$(get_version_component_range 1-3)
ZIP_V=$(get_version_component_range 4-5)
DESCRIPTION="A new Android development environment based on IntelliJ IDEA"
HOMEPAGE="http://developer.android.com/sdk/installing/studio.html"
SRC_URI="http://dl.google.com/dl/android/studio/ide-zips/${STUDIO_V}/${PN}-ide-${ZIP_V}-linux.zip"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~amd64"

DEPEND="app-arch/zip"
RDEPEND=">=virtual/jdk-1.6"
S=${WORKDIR}/${PN}

src_install() {
	local dir="/opt/${P}"
	local exe="${PN}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}/bin/studio.sh" "${dir}/bin/fsnotifier" "${dir}/bin/fsnotifier64"

	newicon "bin/idea.png" "${exe}.png"
	make_wrapper "${exe}" "/opt/${P}/bin/studio.sh"
	make_desktop_entry ${exe} "Android Stuio" "${exe}" "Development;IDE"
}
